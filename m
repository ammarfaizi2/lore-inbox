Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318134AbSIJVCp>; Tue, 10 Sep 2002 17:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318136AbSIJVCp>; Tue, 10 Sep 2002 17:02:45 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:30732 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S318134AbSIJVCm>;
	Tue, 10 Sep 2002 17:02:42 -0400
Date: Tue, 10 Sep 2002 23:06:56 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/pci,hamradio,scsi,aic7xxx,video,zorro clean and mrproper files 4/6
Message-ID: <20020910230656.D18386@mars.ravnborg.org>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <20020910225530.A17094@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020910225530.A17094@mars.ravnborg.org>; from sam@ravnborg.org on Tue, Sep 10, 2002 at 10:55:30PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

o Specify which files to be delted during clean
	- Intermidiate files
o Specify files to be deleted during mrproper
	- Firmware

Note:The patch for the pci makefile apply with an offset of 2 lines.

	Sam

diff -Nru a/drivers/char/Makefile b/drivers/char/Makefile
--- a/drivers/char/Makefile	Tue Sep 10 22:37:55 2002
+++ b/drivers/char/Makefile	Tue Sep 10 22:37:55 2002
@@ -100,6 +100,9 @@
 obj-$(CONFIG_DRM) += drm/
 obj-$(CONFIG_PCMCIA) += pcmcia/
 
+# Files generated that shall be removed upon make clean
+clean := consolemap_deftbl.c defkeymap.c qtronixmap.c
+
 include $(TOPDIR)/Rules.make
 
 $(obj)/consolemap_deftbl.c: $(src)/$(FONTMAPFILE)
diff -Nru a/drivers/net/hamradio/soundmodem/Makefile b/drivers/net/hamradio/soundmodem/Makefile
--- a/drivers/net/hamradio/soundmodem/Makefile	Tue Sep 10 22:37:55 2002
+++ b/drivers/net/hamradio/soundmodem/Makefile	Tue Sep 10 22:37:55 2002
@@ -19,6 +19,10 @@
 host-progs := gentbl
 HOST_LOADLIBES := -lm
 
+# Files generated that shall be removed upon make clean
+clean := sm_tbl_afsk1200.h sm_tbl_afsk2400_7.h sm_tbl_afsk2400_8.h \
+sm_tbl_afsk2666.h sm_tbl_psk4800.h sm_tbl_hapn4800.h sm_tbl_fsk9600.h
+
 include $(TOPDIR)/Rules.make
 
 # Dependencies on generates files need to be listed explicitly
diff -Nru a/drivers/pci/Makefile b/drivers/pci/Makefile
--- a/drivers/pci/Makefile	Tue Sep 10 22:37:55 2002
+++ b/drivers/pci/Makefile	Tue Sep 10 22:37:55 2002
@@ -33,6 +33,9 @@
 
 host-progs := gen-devlist
 
+# Files generated that shall be removed upon make clean
+clean := devlist.h classlist.h
+
 include $(TOPDIR)/Rules.make
 
 # Dependencies on generated files need to be listed explicitly
diff -Nru a/drivers/scsi/Makefile b/drivers/scsi/Makefile
--- a/drivers/scsi/Makefile	Tue Sep 10 22:37:55 2002
+++ b/drivers/scsi/Makefile	Tue Sep 10 22:37:55 2002
@@ -129,6 +129,10 @@
 cpqfc-objs	:= cpqfcTSinit.o cpqfcTScontrol.o cpqfcTSi2c.o \
 		   cpqfcTSworker.o cpqfcTStrigger.o
 
+# Files generated that shall be removed upon make clean
+clean := 53c8xx_d.h 53c8xx_u.h 53c7xx_d.h 53c7xx_u.h \
+         sim710_d.h sim710_u.h 53c700_d.h 53c700_u.h
+
 include $(TOPDIR)/Rules.make
 
 $(obj)/53c7,8xx.o: $(obj)/53c8xx_d.h $(obj)/53c8xx_u.h
@@ -159,4 +163,4 @@
 $(obj)/53c700_d.h: $(src)/53c700.scr $(src)/script_asm.pl
 	$(PERL) -s $(src)/script_asm.pl -ncr7x0_family $@ $(@:_d.h=_u.h) < $<
 
-endif
\ No newline at end of file
+endif
diff -Nru a/drivers/scsi/aic7xxx/Makefile b/drivers/scsi/aic7xxx/Makefile
--- a/drivers/scsi/aic7xxx/Makefile	Tue Sep 10 22:37:55 2002
+++ b/drivers/scsi/aic7xxx/Makefile	Tue Sep 10 22:37:55 2002
@@ -20,6 +20,14 @@
 
 #EXTRA_CFLAGS += -g
 
+# Files generated that shall be removed upon make clean
+clean := aic7xxx_seq.h aic7xxx_reg.h
+
+# Files generated that shall be removed upon make mrproper
+# The list includes all files listed for the clean: target in aicasm/Makefile
+mrproper := $(addprefix \
+aicasm/,aicasm_gram.c aicasm_scan.c y.tab.h aicdb.h y.output aicasm)
+
 include $(TOPDIR)/Rules.make
 
 # Dependencies for generated files need to be listed explicitly
diff -Nru a/drivers/video/Makefile b/drivers/video/Makefile
--- a/drivers/video/Makefile	Tue Sep 10 22:37:55 2002
+++ b/drivers/video/Makefile	Tue Sep 10 22:37:55 2002
@@ -118,6 +118,9 @@
 obj-$(CONFIG_FBCON_STI)           += fbcon-sti.o
 obj-$(CONFIG_FBCON_ACCEL)	  += fbcon-accel.o
 
+# Files generated that shall be removed upon make clean
+clean := promcon_tbl.c
+
 include $(TOPDIR)/Rules.make
 
 $(obj)/promcon_tbl.c: $(src)/prom.uni
diff -Nru a/drivers/zorro/Makefile b/drivers/zorro/Makefile
--- a/drivers/zorro/Makefile	Tue Sep 10 22:37:55 2002
+++ b/drivers/zorro/Makefile	Tue Sep 10 22:37:55 2002
@@ -9,6 +9,9 @@
 
 host-progs 		:= gen-devlist
 
+# Files generated that shall be removed upon make clean
+clean := devlist.h
+
 include $(TOPDIR)/Rules.make
 
 # Dependencies on generated files need to be listed explicitly
