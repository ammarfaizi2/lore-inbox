Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291193AbSBVB6M>; Thu, 21 Feb 2002 20:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291204AbSBVB6C>; Thu, 21 Feb 2002 20:58:02 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:4317 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S291193AbSBVB5w>;
	Thu, 21 Feb 2002 20:57:52 -0500
Message-ID: <3C75B1E0.ADC9B488@vnet.ibm.com>
Date: Thu, 21 Feb 2002 20:50:08 -0600
From: Tom Gall <tom_gall@vnet.ibm.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.2 ppc)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: bug(?): SET_PERSONALITY 2.4.18-rc3
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

While getting 2.4.18-rc[1|2] up and running on ppc64 the following bug
surfaced. Least I think it's a bug. You be the judge. If it's not, we'd
kinda like to know why not.

in fs/binfmt_elf.c I believe the following patch appears to be needed

------8<----------8<--------------------
diff -urN linuxppc64_2_4.bld-rc.borked/fs/binfmt_elf.c
linuxppc64_2_4.bld-rc/fs/binfmt_elf.c
--- linuxppc64_2_4.bld-rc.borked/fs/binfmt_elf.c        Wed Feb 20
13:32:56 2002
+++ linuxppc64_2_4.bld-rc/fs/binfmt_elf.c       Thu Feb 21 17:27:04 2002
@@ -568,6 +565,9 @@
			// printk(KERN_WARNING "ELF: Ambiguous type, using ELF\n");
			interpreter_type = INTERPRETER_ELF;
		}
+	} else {
+		/* Executables without an interpreter also need a personality  */
+		SET_PERSONALITY(elf_ex, ibcs2_interpreter);
	}

	/* OK, we are done with that, now set up the arg stuff,
----8<-------------8<------------------

otherwise a static application would be run without SET_PERSONALITY
being called, which On ppc64, very quickly leads to a bad day.

Regards,

Tom

-- 
Tom Gall - [embedded] [PPC64 | PPC32] Code Monkey
Peace, Love &                  "Where's the ka-boom? There was
Linux Technology Center         supposed to be an earth
http://www.ibm.com/linux/ltc/   shattering ka-boom!"
(w) tom_gall@vnet.ibm.com       -- Marvin Martian
(w) 507-253-4558
(h) tgall@rochcivictheatre.org
