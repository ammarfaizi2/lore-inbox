Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbTIOLAI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 07:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbTIOLAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 07:00:08 -0400
Received: from b0jm34bky18he.bc.hsia.telus.net ([64.180.152.77]:50706 "EHLO
	antichrist") by vger.kernel.org with ESMTP id S261245AbTIOK7H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 06:59:07 -0400
Date: Mon, 15 Sep 2003 03:57:29 -0700
From: carbonated beverage <ramune@net-ronin.org>
To: linux-kernel@vger.kernel.org
Subject: make pdfdocs problem
Message-ID: <20030915105729.GA8576@net-ronin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

	The `make pdfdocs' target still fails for me on the
`writing_usb_drivers' document.  There's one small bug in it, and one
problem I haven't figured out yet.

	There is a malformed <literal>blah<literal> sequence, where the
closing tag is instead an opening tag.  Patch for that below.

	Also, when the TeX back-end runs, for some reason, ConTeX seems
to get referenced and I get this (trimmed):

loading : Context Support Macros / Missing
)
loading : Context Support Macros / PDF
) (/usr/share/texmf/tex/latex/hyperref/nameref.sty) (./writing_usb_driver.out
! Missing $ inserted.
[snippity]
LaTeX Font Warning: Font shape `\\\OT1/cmr/m/n' @undefined
(Font)              using `\\OT1/cmr/m/n' instead on input line 2.
LaTeX Font Warning: Font shape `\\\\OT1/cmr/m/n' @undefined
(Font)              using `\\\OT1/cmr/m/n' instead on input line 2.
[snip]
LaTeX Font Warning: Font shape `[LOTS of \'s]\\\OT1/cmr/m/n' @undefined
(Font)              using `\[LOTS of \s']\OT1/cmr/m/n' instead on input line 2.
[snip]
! TeX capacity exceeded, sorry [save size=5000].

But when I generate it manually from the sgml file that was generated, i.e.:
jade -t tex -d /usr/share/sgml/docbook/utils-0.6.9/docbook-utils.dsl
 -i print -o foo.tex ../Documentation/DocBook/writing_usb_driver.sgml
jadetex foo.tex

I get a proper dvi file.

Converting to RTF also works:

jade -t rtf -d /usr/share/sgml/docbook/utils-0.6.9/docbook-utils.dsl
 -i print -o foo.rtf Documentation/DocBook/writing_usb_driver.sgml 

Anyone have ideas?

-- DN
Daniel

===== Documentation/DocBook/writing_usb_driver.tmpl 1.4 vs edited =====
--- 1.4/Documentation/DocBook/writing_usb_driver.tmpl	Wed Aug 20 09:40:22 2003
+++ edited/Documentation/DocBook/writing_usb_driver.tmpl	Mon Sep 15 03:45:26 2003
@@ -209,7 +209,7 @@
      The driver now needs to verify that this device is actually one that it
      can accept. If so, it returns 0.
      If not, or if any error occurs during initialization, an errorcode
-     (such as <literal>-ENOMEM<literal> or <literal>-ENODEV<literal>)
+     (such as <literal>-ENOMEM</literal> or <literal>-ENODEV</literal>)
      is returned from the probe function.
   </para>
   <para>
