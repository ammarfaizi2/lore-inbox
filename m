Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbUCEVnH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 16:43:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261223AbUCEVnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 16:43:05 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:53265 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261202AbUCEVmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 16:42:47 -0500
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: initrd does not boot in 2.6.3, working in 2.4.25
Date: Fri, 5 Mar 2004 23:28:01 +0200
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
References: <200403051238.53470.vda@port.imtp.ilyichevsk.odessa.ua> <200403051831.31271.vda@port.imtp.ilyichevsk.odessa.ua> <20040305170619.GX655@holomorphy.com>
In-Reply-To: <20040305170619.GX655@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403052328.01720.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 05 March 2004 19:06, William Lee Irwin III wrote:
> On Friday 05 March 2004 13:04, William Lee Irwin III wrote:
> >> nfsroot works in 2.6.3 and above here. I'm not sure you need it per se
> >> for initrd's; I think the way it's intended to work with that is for
> >> the scripts to configure network interfaces, mount the nfsroot, and then
> >> pivot_root(). Can you try without initrd?
> >> Also, try passing ip= for these things.
>
> On Fri, Mar 05, 2004 at 06:31:31PM +0200, Denis Vlasenko wrote:
> > I run these things everyday.
> > nfsroot and ip=.... works, no question about that.
> > Just imagine all-modular kernel which needs to load ethernet driver
> > first, *then* mount nfs root and pivot_root. Or nfsroot-over-wireless :)
> > --
> > vda
>
> For this, you should probably script the initrd to do the IP
> configuration and mount the nfsroot before pivot_root().

Exactly. For now I don't really need it, but decided to
try it just in case I'll need it later. I stuffed
udhcp and nfs tools into initrd, played with it a bit,
and finally managed to make it work under 2.4.25.

Then I tried 2.6.3 with the _same_ initrd and same
bootloader.

2.6.3 refuses to recognize my initrd as root fs.
It even mounts it on / but then suddenly acts
as if I specified root=/dev/nfs. I _didn't_.
I said root=/dev/ram, then tried root=/dev/ram0,
root=/dev/ram/0, root=/dev/rd/0.
All to no avail:

VFS: Mounted root (ext2 filesystem)  <-- mounts initrd on /
Mounted devfs on /dev

(here 2.4.25 would say "Freed unused kernel mem..." and happily exec init)

Root-NFS: No NFS server available, giving up
VFS: Unable to mount root fs via NFS, t
--
vda

