Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263866AbTKSFxg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 00:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263868AbTKSFxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 00:53:36 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:20998 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S263866AbTKSFxe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 00:53:34 -0500
Date: Wed, 19 Nov 2003 06:53:32 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: use ELF sections for get_wchan()
Message-ID: <20031119055332.GA934@mars.ravnborg.org>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20031118074448.GD19856@holomorphy.com> <20031118084336.A28004@flint.arm.linux.org.uk> <20031118084529.GK22764@holomorphy.com> <20031118085022.GL22764@holomorphy.com> <20031119031337.GM22764@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031119031337.GM22764@holomorphy.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 18, 2003 at 07:13:37PM -0800, William Lee Irwin III wrote:
> willy said I should use .sched.text instead of .text.sched; this fixes
> it up to do that.

Hi wli,
how about utilising asm-generic/vmlinux.h.S now that you are touching so
many .lds files?
Something like the attached could be used?

That will simplify and consolidate the the .lds files, but full
flexibility remains.

I noticed that there were small diferences between the individual
architectures, but specifying only content of the section should allow
it to be used all over.

	Sam


===== include/asm-generic/vmlinux.lds.h 1.8 vs edited =====
--- 1.8/include/asm-generic/vmlinux.lds.h	Thu Jun 12 02:40:10 2003
+++ edited/include/asm-generic/vmlinux.lds.h	Wed Nov 19 06:48:40 2003
@@ -45,6 +45,15 @@
 		*(__ksymtab_strings)					\
 	}
 
+#define TEXT_CONTENT							\
+		_stext = .;						\
+		*(.text)						\
+		__schduling_functions_start_here = .;			\
+		*(.sched.text)						\
+		__scheduling_functions_end_here = .;			\
+		*(.fixup)						\
+		*(.gnu.warning)						
+
 #define SECURITY_INIT							\
 	.security_initcall.init : {					\
 		__security_initcall_start = .;				\
