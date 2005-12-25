Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750867AbVLYQRe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbVLYQRe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 11:17:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750869AbVLYQRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 11:17:34 -0500
Received: from rain.plan9.de ([193.108.181.162]:18861 "HELO rain.plan9.de")
	by vger.kernel.org with SMTP id S1750867AbVLYQRe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 11:17:34 -0500
Date: Sun, 25 Dec 2005 17:17:30 +0100
From: Marc Lehmann <schmorp@schmorp.de>
To: linux-kernel@vger.kernel.org
Subject: Re: read returns EAGAIN on a _blocking_ socket, but should not? (solved)
Message-ID: <20051225161730.GA21379@schmorp.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20051225151611.GA20443@schmorp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051225151611.GA20443@schmorp.de>
X-PGP: "1024D/DA743396 1999-01-26 Marc Alexander Lehmann <schmorp@schmorp.de>
       Key fingerprint = 475A FE9B D1D4 039E 01AC  C217 A1E8 0270 DA74 3396"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 25, 2005 at 04:16:11PM +0100, Marc Lehmann <schmorp@schmorp.de> wrote:
> Hi!
> 
> The SuS documents EAGAIN for read(2) as:

Argl, false alarm, very very sorry :(

>    sendmsg(3, {msg_name(0)=NULL, msg_iov(1)=[{"\0", 1}], msg_controllen=20, {cmsg_len=20, cmsg_level=SOL_SOCKET, cmsg_type=SCM_RIGHTS, {3}}, msg_flags=MSG_OOB|MSG_DONTROUTE}, 0)                            = 1

Due to a bug, this sendmsg call passes the wrong fd (3), which the other
process then sets to non-blocking.

Again, sorry :(

-- 
                The choice of a
      -----==-     _GNU_
      ----==-- _       generation     Marc Lehmann
      ---==---(_)__  __ ____  __      pcg@goof.com
      --==---/ / _ \/ // /\ \/ /      http://schmorp.de/
      -=====/_/_//_/\_,_/ /_/\_\      XX11-RIPE
