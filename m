Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264230AbTH1U1L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 16:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264224AbTH1U1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 16:27:11 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:28583 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S264290AbTH1U0b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 16:26:31 -0400
Subject: RE: KDB in the mainstream 2.4.x kernels?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>
Cc: Andi Kleen <ak@muc.de>, Greg Stark <gsstark@mit.edu>,
       Martin Pool <mbp@sourcefrog.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <D36CE1FCEFD3524B81CA12C6FE5BCAB002FFE662@fmsmsx406.fm.intel.com>
References: <D36CE1FCEFD3524B81CA12C6FE5BCAB002FFE662@fmsmsx406.fm.intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062102278.24978.52.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 28 Aug 2003 21:24:39 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-08-28 at 18:08, Tolentino, Matthew E wrote:
> > I've seen workable non forth versions of the proposal yes. It isnt 
> > actually that hard to do for most video cards 
> 
> Interesting.  So did the interpreted forth (or other) program then interact with the VGA BIOS or was it more generic? 

It consisted simply of a list of in/out values. Thats sufficient for
most cards it turned out. It expected the X server to dump the sequence
of values to the kernel.

A BIOS32/ACPI/whatever is currently trendy service to save/restore video
states would actually be a real help to a lot of things. I guess the
perfect would API would support something like

    SaveCurrentMode
    SetMode (some properties)
    GetLinearFBDetails()
    RestoreSavedMode
    LoadColor() [for 8bit modes]

ie roughly what vesa bios provides. Given the cost of executing a
virtual machine like ACPI its less clear if cards could describe
basic acceleration this way, at least if it was something like ACPI
or forth which is hard to compile. A bytecode description that can
be turned into native code obviously has different properties.

