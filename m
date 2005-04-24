Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262355AbVDXSAa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262355AbVDXSAa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 14:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262357AbVDXSA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 14:00:29 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:24444 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262355AbVDXSAY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 14:00:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=lDIjCSTgUhwVA80lCnrGd8BkndaEVAbLgLd+BhJMoaRryAqzWiHEObPyOotwaZRpo62CoE3QLFMgUGuEQN/GgIa3UxypX5JXGDcrwSsubtvmHUCRJEgPtF1j1Fy1dgrAEKoI/w5LzpSWQ/gNkHu+pEru1H8l+aaLecyxBzwJRlw=
From: Emanuele Giaquinta <emanuele.giaquinta@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Makefile: fix for compatibility with *emacs ctags
Date: Sun, 24 Apr 2005 20:00:22 +0200
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504242000.22740.emanuele.giaquinta@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've noticed that, starting from linux-2.6.12-rc1, in the top Makefile the
"cmd_tags" variable has been changed in a way incompatible with *emacs ctags.
Since the "--extra" option exists only in "exuberant ctags", it should be
included in the CTAGSF shell variable.

--- linux-2.6.12-rc3/Makefile   2005-04-24 19:53:29.000000000 +0200
+++ linux/Makefile      2005-04-24 19:53:42.000000000 +0200
@@ -1188,8 +1188,8 @@
 quiet_cmd_tags = MAKE   $@
 define cmd_tags
        rm -f $@; \
-       CTAGSF=`ctags --version | grep -i exuberant >/dev/null && echo "-I __initdata,__exitdata,EXPORT_SYMBOL,EXPORT_SYMBOL_GPL"`; \
-       $(all-sources) | xargs ctags $$CTAGSF -a --extra=+f
+       CTAGSF=`ctags --version | grep -i exuberant >/dev/null && echo "-I __initdata,__exitdata,EXPORT_SYMBOL,EXPORT_SYMBOL_GPL --extra=+f"`; \
+       $(all-sources) | xargs ctags $$CTAGSF -a
 endef
 
 TAGS: FORCE


