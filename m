Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267478AbUJHDG3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267478AbUJHDG3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 23:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267588AbUJGS00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 14:26:26 -0400
Received: from [66.75.162.135] ([66.75.162.135]:23462 "EHLO
	ms-smtp-03-eri0.socal.rr.com") by vger.kernel.org with ESMTP
	id S267668AbUJGSXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 14:23:12 -0400
Subject: Re: 2.6.9-rc3-mm3: `risc_code_addr01' multiple definition
From: Andrew Vasquez <andrew.vasquez@qlogic.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1097172815.12495.51.camel@praka>
References: <20041007015139.6f5b833b.akpm@osdl.org>
	 <20041007165849.GA4493@stusta.de>  <1097170149.12535.27.camel@praka>
	 <1097171420.1718.332.camel@mulgrave>  <1097172815.12495.51.camel@praka>
Content-Type: multipart/mixed; boundary="=-LdplO5tNjdQnYTQyjBpH"
Organization: QLogic Corporation
Date: Thu, 07 Oct 2004 11:15:36 -0700
Message-Id: <1097172936.12495.53.camel@praka>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-LdplO5tNjdQnYTQyjBpH
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2004-10-07 at 11:13 -0700, Andrew Vasquez wrote:
> On Thu, 2004-10-07 at 12:50 -0500, James Bottomley wrote:
> > On Thu, 2004-10-07 at 12:29, Andrew Vasquez wrote:
> > > Hmm, seems the additional 1040 support in qla1280.c is causing name
> > > clashes with the firmware image in qlogicfc_asm.c.  Try out the attached
> > > patch (not tested) which provides the 1040 firmware image unique
> > > variable names.
> > > 
> > > Looks like there would be some name clashes in qlogicfc and qlogicisp.
> > 
> > Is there any reason for these firmware image pointers not to be static? 
> > At least for these drivers which are single files.
> > 
> 
> That certainly seems like a reasonable option for qlogicfc and
> qlogicisp.  Attached is a small patch which will limit the scope of
> qlogicfc_asm variables.
> 

Sorry, patch attached.

--
av

--=-LdplO5tNjdQnYTQyjBpH
Content-Disposition: attachment; filename=fw_vars_static_qlogicfc.diff
Content-Type: text/plain; name=fw_vars_static_qlogicfc.diff; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- linux-2.6.9-rc3-mm3/drivers/scsi/qlogicfc_asm.c~	2004-10-07 11:09:44.971796784 -0700
+++ linux-2.6.9-rc3-mm3/drivers/scsi/qlogicfc_asm.c	2004-10-07 11:10:08.103280264 -0700
@@ -19,10 +19,10 @@
  *	Firmware Version 1.19.16 (10:36 Nov 02, 2000)
  */
 
-unsigned short risc_code_addr01 = 0x1000 ;
+static unsigned short risc_code_addr01 = 0x1000 ;
 
-unsigned short risc_code_length2100 = 0x9260;
-unsigned short risc_code2100[] = {
+static unsigned short risc_code_length2100 = 0x9260;
+static unsigned short risc_code2100[] = {
 	0x0078, 0x102d, 0x0000, 0x9260, 0x0000, 0x0001, 0x0013, 0x0010,
 	0x0017, 0x2043, 0x4f50, 0x5952, 0x4947, 0x4854, 0x2031, 0x3939,
 	0x3920, 0x514c, 0x4f47, 0x4943, 0x2043, 0x4f52, 0x504f, 0x5241,
@@ -4729,8 +4729,8 @@ unsigned short risc_code2100[] = {
  *	Firmware Version 2.01.27 (11:07 Dec 18, 2000)
  */
 
-unsigned short risc_code_length2200 = 0x9cbf;
-unsigned short risc_code2200[] = { 
+static unsigned short risc_code_length2200 = 0x9cbf;
+static unsigned short risc_code2200[] = { 
 	0x0470, 0x0000, 0x0000, 0x9cbf, 0x0000, 0x0002, 0x0001, 0x001b,
 	0x0017, 0x2043, 0x4f50, 0x5952, 0x4947, 0x4854, 0x2031, 0x3939,
 	0x3920, 0x514c, 0x4f47, 0x4943, 0x2043, 0x4f52, 0x504f, 0x5241,

--=-LdplO5tNjdQnYTQyjBpH--

