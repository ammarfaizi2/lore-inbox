Return-Path: <linux-kernel-owner@vger.kernel.org>
thread-index: AcQVpKgrfyUJrZzIQKmWEnABh/67lA==
Envelope-to: paul@sumlocktest.fsnet.co.uk
Delivery-date: Mon, 05 Jan 2004 06:08:58 +0000
Message-ID: <02cf01c415a4$a82b0cf0$d100000a@sbs2003.local>
X-Mailer: Microsoft CDO for Exchange 2000
Content-Class: urn:content-classes:message
From: "Dmitry Torokhov" <dtor_core@ameritech.net>
Importance: normal
Priority: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
To: <Administrator@osdl.org>
Subject: [PATCH 1/3] Fix compile error in 98busmouse.c module
Date: Mon, 29 Mar 2004 16:44:01 +0100
User-Agent: KMail/1.5.4
Cc: "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
References: <200401030350.43437.dtor_core@ameritech.net> <200401050059.25031.dtor_core@ameritech.net>
In-Reply-To: <200401050059.25031.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: <linux-kernel-owner@vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 29 Mar 2004 15:44:03.0359 (UTC) FILETIME=[A95EAAF0:01C415A4]

===================================================================


ChangeSet@1.1580, 2004-01-04 23:57:27-05:00, dtor_core@ameritech.net
  Input: Fix 98busmouse compile error -
         have interrupt routine return IRQ_HANDLED


 98busmouse.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)


===================================================================



diff -Nru a/drivers/input/mouse/98busmouse.c b/drivers/input/mouse/98busmouse.c
--- a/drivers/input/mouse/98busmouse.c	Mon Jan  5 00:45:57 2004
+++ b/drivers/input/mouse/98busmouse.c	Mon Jan  5 00:45:57 2004
@@ -74,7 +74,7 @@
 static int pc98bm_irq = PC98BM_IRQ;
 static int pc98bm_used = 0;
 
-static void pc98bm_interrupt(int irq, void *dev_id, struct pt_regs *regs);
+static irqreturn_t pc98bm_interrupt(int irq, void *dev_id, struct pt_regs *regs);
 
 static int pc98bm_open(struct input_dev *dev)
 {
@@ -113,7 +113,7 @@
 	},
 };
 
-static void pc98bm_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t pc98bm_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	char dx, dy;
 	unsigned char buttons;
@@ -137,6 +137,8 @@
 	input_sync(&pc98bm_dev);
 
 	outb(PC98BM_ENABLE_IRQ, PC98BM_CONTROL_PORT);
+
+	return IRQ_HANDLED;
 }
 
 #ifndef MODULE
