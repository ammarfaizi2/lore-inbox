Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267558AbUJGS2T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267558AbUJGS2T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 14:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267632AbUJGS14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 14:27:56 -0400
Received: from [66.75.162.135] ([66.75.162.135]:24736 "EHLO
	ms-smtp-03-eri0.socal.rr.com") by vger.kernel.org with ESMTP
	id S267558AbUJGSVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 14:21:24 -0400
Subject: Re: 2.6.9-rc3-mm3: `risc_code_addr01' multiple definition
From: Andrew Vasquez <andrew.vasquez@qlogic.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1097171420.1718.332.camel@mulgrave>
References: <20041007015139.6f5b833b.akpm@osdl.org>
	 <20041007165849.GA4493@stusta.de>  <1097170149.12535.27.camel@praka>
	 <1097171420.1718.332.camel@mulgrave>
Content-Type: text/plain
Organization: QLogic Corporation
Date: Thu, 07 Oct 2004 11:13:35 -0700
Message-Id: <1097172815.12495.51.camel@praka>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-07 at 12:50 -0500, James Bottomley wrote:
> On Thu, 2004-10-07 at 12:29, Andrew Vasquez wrote:
> > Hmm, seems the additional 1040 support in qla1280.c is causing name
> > clashes with the firmware image in qlogicfc_asm.c.  Try out the attached
> > patch (not tested) which provides the 1040 firmware image unique
> > variable names.
> > 
> > Looks like there would be some name clashes in qlogicfc and qlogicisp.
> 
> Is there any reason for these firmware image pointers not to be static? 
> At least for these drivers which are single files.
> 

That certainly seems like a reasonable option for qlogicfc and
qlogicisp.  Attached is a small patch which will limit the scope of
qlogicfc_asm variables.

We could also strip out the !UNIQUE_FW_NAME stuff out of the qla1280.c
driver.  Firmware updates to those ISPs will likely _not_ happen, so we
don't need to worry about adding the static modifier at each churn as we
would with the qla2xxx driver.  I'll forward along a patch in a later
email.

>From the qla2xxx side, I could also add a '-DUNIQUE_FW_NAME' to the
unifdef script I run before sending updates upstream -- something I
recall Christoph wanting earlier.  

--
av

