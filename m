Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129164AbRBSJsj>; Mon, 19 Feb 2001 04:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129245AbRBSJsa>; Mon, 19 Feb 2001 04:48:30 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:2401 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S129164AbRBSJsX>; Mon, 19 Feb 2001 04:48:23 -0500
Date: Mon, 19 Feb 2001 03:47:42 -0600 (CST)
From: Philipp Rumpf <prumpf@mandrakesoft.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org, prumpf@parcelfarce.linux.theplanet.co.uk
Subject: Re: Linux 2.4.1-ac15
In-Reply-To: <E14TXcs-0001IW-00@the-village.bc.nu>
Message-ID: <Pine.LNX.3.96.1010219034311.16489B-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Feb 2001, Alan Cox wrote:
> 	Question of the day for the VM folks:
> 	If CPU1 is loading the exception tables for a module and
> 	CPU2 faults.. what happens 8)

"loading" == in sys_create_module ?

The module list is modified atomically, so either we search the new table
or we don't, but we never see intermediate states.  Not searching the new
table shouldn't be a problem as we shouldn't run module code until
sys_init_module time.

