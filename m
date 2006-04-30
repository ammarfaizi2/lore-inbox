Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750821AbWD3Nb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbWD3Nb5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 09:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751076AbWD3Nb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 09:31:57 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:14984 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S1750821AbWD3Nb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 09:31:57 -0400
From: "Niklas Fondberg" <niklas.fondberg@tilgin.com>
To: <linux-kernel@vger.kernel.org>
Subject: IGMP unsolicited count don't work in 2.4.30?
Date: Sun, 30 Apr 2006 15:31:50 +0200
Message-ID: <006001c66c5a$6f9574c0$a901a8c0@NIFHP6220>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Thread-Index: AcZsWm9s52LMo4WkRoevB32+gPhWRQ==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm posting to the list because we are using Linux in different IPTV Set top
boxes.
I have two questions (the fist is possibly a bug);

1. Up to at least version 2.4.22 we see that after an initial membership
report (IGMP join) two more reports are sent, with an interval of around
500ms. 
This is very good and true to the specification (IGMP v2 rfc2236 at least).
However version 2.4.30 sends only one membership report and this causes
problems with some switches.
IGMP_Unsolicited_Report_Count is defined to 2 but if igmp_mod_timer is
called (on a igmp_query?) it is reset so the loop of adding the 2 more
reports are never done. This is just a hunch but our tests show that we
never get more than 1 report.
Anybody know if this is a bug?

2. Every membership report is put in a timer (igmp_start_timer) with a
max_delay. The max delay of the first report is 1
(IGMP_Initial_Report_Delay) so the value net_random returns will be the
earliest the first report is sent. Would it break the implementation if the
first membership report is sent right away without being put in a timer
queue?

(I'm not subscribed to the list so please CC me in the reply)

Niklas Fondberg



