Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265564AbTABFMi>; Thu, 2 Jan 2003 00:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265567AbTABFMi>; Thu, 2 Jan 2003 00:12:38 -0500
Received: from main.gmane.org ([80.91.224.249]:29070 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S265564AbTABFMh>;
	Thu, 2 Jan 2003 00:12:37 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: "Andres Salomon" <dilinger@voxel.net>
Subject: [PATCH] Re: Linux v2.5.54 - OHCI-HCD build fails
Date: Thu, 02 Jan 2003 00:16:33 -0500
Message-ID: <pan.2003.01.02.05.16.23.282892@voxel.net>
References: <Pine.LNX.4.44.0301011935410.8506-100000@penguin.transmeta.com> <20030102045245.GA1464@Master.Wizards> <20030102050007.GB1464@Master.Wizards>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@main.gmane.org
User-Agent: Pan/0.13.3 (That cat's something I can't explain)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes it.  data0 and data1 are defined inside a DEBUG #ifdef context,
and used outside of it.
 
On Thu, 02 Jan 2003 00:00:07 -0500, Murray J. Root wrote:

> On Wed, Jan 01, 2003 at 11:52:45PM -0500, Murray J. Root wrote:
>> On Wed, Jan 01, 2003 at 07:43:40PM -0800, Linus Torvalds wrote:
>> > 
>> > Happy new year to you all, hopefully most of you are back from the dead 
>> > and the hangovers are all long gone.  And if not, I'm told reading a large 
>> > kernel patch is _just_ the medication for whatever ails you.
>> > 
>> > The 2.5.54 patch is largely mainly a big collection of various small
>> > things, all over the place (diffstat shows a long list of small changes,
>> > with some noticeable activity in UML, the MPT fusion driver and some of
>> > the fbcon drivers).
>> > 
>> > Various module updates (deprecated functions, updated loaders etc), usb, 
>> > m68k, x86-64 updates, kbuild stuff etc etc.
>> 
>> Build error:
>> 
>> In file included from drivers/usb/host/ohci-hcd.c:137:
>> drivers/usb/host/ohci-dbg.c: In function `show_list':
>> drivers/usb/host/ohci-dbg.c:358: `data1' undeclared (first use in this function)
>> drivers/usb/host/ohci-dbg.c:358: (Each undeclared identifier is reported only once
>> drivers/usb/host/ohci-dbg.c:358: for each function it appears in.)
>> drivers/usb/host/ohci-dbg.c:358: `data0' undeclared (first use in this function)
>> make[3]: *** [drivers/usb/host/ohci-hcd.o] Error 1
>> 
> 
> checking "USB verbose debug nessages" lets it build
> not what I wanted, but better than no ohci-hcd



--- a/drivers/usb/host/ohci-dbg.c	2003-01-02 00:06:40.000000000 -0500
+++ b/drivers/usb/host/ohci-dbg.c	2003-01-02 00:09:22.000000000 -0500
@@ -9,9 +9,7 @@
  */
  
 /*-------------------------------------------------------------------------*/
-static const char data0 [] = "DATA0";
-static const char data1 [] = "DATA1";
-
+ 
 #ifdef DEBUG
 
 #define edstring(ed_type) ({ char *temp; \
@@ -218,6 +216,9 @@
 	ohci_dump_roothub (controller, 1);
 }
 
+static const char data0 [] = "DATA0";
+static const char data1 [] = "DATA1";
+
 static void ohci_dump_td (char *label, struct td *td)
 {
 	u32	tmp = le32_to_cpup (&td->hwINFO);



