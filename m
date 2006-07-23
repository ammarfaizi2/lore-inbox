Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751256AbWGWRve@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbWGWRve (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 13:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbWGWRve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 13:51:34 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:57811 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751256AbWGWRvd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 13:51:33 -0400
Date: Sun, 23 Jul 2006 19:51:11 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Olaf Hering <olh@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cc-version not available to change EXTRA_CFLAGS
Message-ID: <20060723175111.GA22861@mars.ravnborg.org>
References: <20060121180805.GA15761@suse.de> <20060719090204.GA4980@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060719090204.GA4980@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2006 at 11:02:04AM +0200, Olaf Hering wrote:
>  On Sat, Jan 21, Olaf Hering wrote:
> 
> > 
> > I want to add a gcc version check for reiserfs, on akpms request.
> 
> This debug patch still doesnt work in 2.6.18-rc2:
> 
> 
> make -kj 14 O=$O
> 
> scripts/gcc-version.sh: line 11: _c_flags: command not found
> scripts/gcc-version.sh: line 12: _c_flags: command not found
> + '[' 0000 -lt 0500 ']'
> + echo -O1

Fixed by following patch. Please consider using: cc-ifversion (see
Documentation/kbuild/makefiles.txt

	Sam

commit 045cfddb5f89722259c90fb742e201d289d94092
Author: Sam Ravnborg <sam@mars.ravnborg.org>
Date:   Sun Jul 23 19:49:45 2006 +0200

    kbuild: always use $(CC) for $(call cc-version)
    
    The possibility to specify an optional parameter did not work out as
    expected and it was not used - so remove the possibility.
    
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 7a18353..dbb20a6 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -81,8 +81,7 @@ cc-option-align = $(subst -functions=0,,
 
 # cc-version
 # Usage gcc-ver := $(call cc-version, $(CC))
-cc-version = $(shell $(CONFIG_SHELL) $(srctree)/scripts/gcc-version.sh \
-              $(if $(1), $(1), $(CC)))
+cc-version = $(shell $(CONFIG_SHELL) $(srctree)/scripts/gcc-version.sh $(CC))
 
 # cc-ifversion
 # Usage:  EXTRA_CFLAGS += $(call cc-ifversion, -lt, 0402, -O1)
