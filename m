Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964945AbWEJNUd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964945AbWEJNUd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 09:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbWEJNUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 09:20:33 -0400
Received: from taurus.voltaire.com ([193.47.165.240]:64110 "EHLO
	taurus.voltaire.com") by vger.kernel.org with ESMTP
	id S1750796AbWEJNUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 09:20:32 -0400
Date: Wed, 10 May 2006 16:20:30 +0300 (IDT)
From: Or Gerlitz <ogerlitz@voltaire.com>
X-X-Sender: ogerlitz@zuben
To: rdreier@cisco.com
cc: openib-general@openib.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/6] iSER (iSCSI Extensions for RDMA) initiator
Message-ID: <Pine.LNX.4.44.0605101618360.17835-100000@zuben>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 10 May 2006 13:20:30.0615 (UTC) FILETIME=[82AD3A70:01C67434]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland,

The patch series that follows contains the iSER code which we want to submit
upstream for 2.6.18, fixed with the comments which we got in the previous post.

LKML reviewers are reminded to CC openib-general@openib.org on your responses.

Below is a log and diffstat over the changes from the previous post which is 
archived @ http://openib.org/pipermail/openib-general/2006-April/020616.html

To have this code compiled you would need to get the iscsi updates for 2.6.18 
into your source tree, that is pull/sync with include/scsi and drivers/scsi of
the scsi-misc-2.6 git tree. 

There's one patch which is not yet merged there and without it iser's 
compilation fails. The patch is named "iscsi: add transport end point callbacks"
and i will send it to you offlist.

+ use direct BUG_ON & BUG calls instead of the iser_bug macro

+ removed usage of SVN keywords such as $LastChangedDate and $Rev

+ few fixes related to the managment of the ib conn list

+ two fixes for checks done at the ib conn state machine flow  

+ changed iser ib conn state management to be done with an int variable keeping
  the state and a lock. When a related race is possible the lock is used to check
  (comp) or change (comp_exch) the state. When no race can happen the state is
  just examined or changed.

+ always call rdma_disconnect in iser_conn_terminate such the CMA will move the
  QP state to ERROR and we will get the FLUSHES on all the pending RX/TX WRs

+ make iser_free_device_ib_res void, change the out goto label name of 
  iser_device_find_by_ib_device

+ some whitespacing cleanups

 Makefile         |    4 -
 iscsi_iser.c     |   18 ++----
 iscsi_iser.h     |   21 +++----
 iser_initiator.c |   24 ++++-----
 iser_memory.c    |   12 +---
 iser_verbs.c     |  145 +++++++++++++++++++++++++++++++------------------------
 6 files changed, 120 insertions(+), 104 deletions(-)

Or.



