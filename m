Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261952AbVANK7F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261952AbVANK7F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 05:59:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261953AbVANK7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 05:59:05 -0500
Received: from opersys.com ([64.40.108.71]:1555 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261952AbVANK6v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 05:58:51 -0500
Message-ID: <41E7A7A6.3060502@opersys.com>
Date: Fri, 14 Jan 2005 06:06:14 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: Nikita Danilov <nikita@clusterfs.com>, linux-kernel@vger.kernel.org,
       Tom Zanussi <zanussi@us.ibm.com>
Subject: Re: 2.6.11-rc1-mm1
References: <20050114002352.5a038710.akpm@osdl.org> <m1zmzcpfca.fsf@muc.de> <m17jmg2tm8.fsf@clusterfs.com> <20050114103836.GA71397@muc.de>
In-Reply-To: <20050114103836.GA71397@muc.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andi Kleen wrote:
> When you have a timing bug and your logger starts to block randomly
> you also won't debug anything. Fix is to make your buffers bigger.

relayfs allows you to choose which is best for you.

>From Documentation/filesystems/relayfs.txt:
...
int    relay_open(channel_path, bufsize, nbufs, channel_flags,
		  channel_callbacks, start_reserve, end_reserve,
		  rchan_start_reserve, resize_min, resize_max, mode,
		  init_buf, init_buf_size)
...
- resize_min - if set, this signifies that the channel is
  auto-resizeable.  The value specifies the size that the channel will
  try to maintain as a normal working size, and that it won't go
  below.  The client makes use of the resizing callbacks and
  relay_realloc_buffer() and relay_replace_buffer() to actually effect
  the resize.

- resize_max - if set, this signifies that the channel is
  auto-resizeable.  The value specifies the maximum size the channel
  can have as a result of resizing.
...

LTT uses fixed-sized channels, but the implementation of printk-
over-relayfs used resize_min and resize_max to allow automatic
sizing (grep for relay_open):
http://www.opersys.com/ftp/pub/relayfs/patch-printk-on-relayfs-2.6.0-test1

... now I'm going to get some sleep ... I'll catch up later with
further discussion ...

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
