Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262331AbVBKUTG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262331AbVBKUTG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 15:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262330AbVBKUTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 15:19:06 -0500
Received: from moutng.kundenserver.de ([212.227.126.190]:11751 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262331AbVBKUMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 15:12:47 -0500
Date: Fri, 11 Feb 2005 21:12:42 +0100
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, developers@melware.de
Subject: [PATCH] 2.6 ISDN Eicon driver: code cleanups
Message-ID: <420D11BA.mail2D5112ZB4@phoenix.one.melware.de>
User-Agent: nail 11.4 8/29/04
MIME-Version: 1.0
Content-Type: application/octet-stream; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: armin@melware.de (Armin Schindler)
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:4f0aeee4703bc17a8237042c4702a75a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanups (initially send by Adrian Bunk):
- make some needlessly global code static
- removed obsolete #define OLD_MAX_DESCRIPTORS
- removed more platform independend code not used in linux
- removed dos-<CR> at end of lines 
- fix indentation in already modified files


Signed-off-by: Armin Schindler <armin@melware.de>



diff -u linux.orig/drivers/isdn/hardware/eicon/capifunc.c linux/drivers/isdn/hardware/eicon/capifunc.c
--- linux.orig/drivers/isdn/hardware/eicon/capifunc.c	2005-02-11 17:53:26.000000000 +0100
+++ linux/drivers/isdn/hardware/eicon/capifunc.c	2005-02-11 20:41:25.391403782 +0100
@@ -1,4 +1,4 @@
-/* $Id: capifunc.c,v 1.61.4.5 2004/08/27 20:10:12 armin Exp $
+/* $Id: capifunc.c,v 1.61.4.7 2005/02/11 19:40:25 armin Exp $
  *
  * ISDN interface module for Eicon active cards DIVA.
  * CAPI Interface common functions
@@ -64,7 +64,7 @@
  */
 static void no_printf(unsigned char *, ...);
 #include "debuglib.c"
-void xlog(char *x, ...)
+static void xlog(char *x, ...)
 {
 #ifndef DIVA_NO_DEBUGLIB
 	va_list ap;
@@ -157,7 +157,7 @@
 	while (num < MAX_DESCRIPTORS) {
 		a = &adapter[num];
 		if (!a->Id)
-				break;
+			break;
 		num++;
 	}
 	return(num + 1);
@@ -353,7 +353,7 @@
 	if (k == 0) {
 		if (li_config_table) {
 			list_add((struct list_head *)li_config_table, free_mem_q);
-		li_config_table = NULL;
+			li_config_table = NULL;
 		}
 	} else {
 		if (a->li_base < k) {
@@ -1212,7 +1212,7 @@
 void DIVA_EXIT_FUNCTION finit_capifunc(void)
 {
 	do_api_remove_start();
-		    divacapi_disconnect_didd();
+	divacapi_disconnect_didd();
 	divacapi_remove_cards();
 	remove_main_structs();
 	diva_os_destroy_spin_lock(&api_lock, "capifunc");
diff -u linux.orig/drivers/isdn/hardware/eicon/dadapter.c linux/drivers/isdn/hardware/eicon/dadapter.c
--- linux.orig/drivers/isdn/hardware/eicon/dadapter.c	2005-02-11 17:51:36.000000000 +0100
+++ linux/drivers/isdn/hardware/eicon/dadapter.c	2005-02-11 20:41:25.392403663 +0100
@@ -106,7 +106,7 @@
   return adapter handle (> 0) on success
   return -1 adapter array overflow
   -------------------------------------------------------------------------- */
-int diva_didd_add_descriptor (DESCRIPTOR* d) {
+static int diva_didd_add_descriptor (DESCRIPTOR* d) {
  diva_os_spin_lock_magic_t      irql;
  int i;
  if (d->type == IDI_DIMAINT) {
@@ -143,7 +143,7 @@
   return adapter handle (> 0) on success
   return 0 on success
   -------------------------------------------------------------------------- */
-int diva_didd_remove_descriptor (IDI_CALL request) {
+static int diva_didd_remove_descriptor (IDI_CALL request) {
  diva_os_spin_lock_magic_t      irql;
  int i;
  if (request == MAdapter.request) {
@@ -171,7 +171,7 @@
   Read adapter array
   return 1 if not enough space to save all available adapters
    -------------------------------------------------------------------------- */
-int diva_didd_read_adapter_array (DESCRIPTOR* buffer, int length) {
+static int diva_didd_read_adapter_array (DESCRIPTOR* buffer, int length) {
  diva_os_spin_lock_magic_t      irql;
  int src, dst;
  memset (buffer, 0x00, length);
diff -u linux.orig/drivers/isdn/hardware/eicon/dadapter.h linux/drivers/isdn/hardware/eicon/dadapter.h
--- linux.orig/drivers/isdn/hardware/eicon/dadapter.h	2005-02-11 17:53:42.000000000 +0100
+++ linux/drivers/isdn/hardware/eicon/dadapter.h	2005-02-11 20:41:25.392403663 +0100
@@ -25,11 +25,10 @@
  */
 #ifndef __DIVA_DIDD_DADAPTER_INC__
 #define __DIVA_DIDD_DADAPTER_INC__
+ 
 void diva_didd_load_time_init (void);
 void diva_didd_load_time_finit (void);
-int diva_didd_add_descriptor (DESCRIPTOR* d);
-int diva_didd_remove_descriptor (IDI_CALL request);
-int diva_didd_read_adapter_array (DESCRIPTOR* buffer, int length);
-#define OLD_MAX_DESCRIPTORS     16
+
 #define NEW_MAX_DESCRIPTORS     64
+
 #endif
diff -u linux.orig/drivers/isdn/hardware/eicon/di.c linux/drivers/isdn/hardware/eicon/di.c
--- linux.orig/drivers/isdn/hardware/eicon/di.c	2005-02-11 17:51:22.000000000 +0100
+++ linux/drivers/isdn/hardware/eicon/di.c	2005-02-11 20:41:25.394403426 +0100
@@ -42,10 +42,7 @@
 /*------------------------------------------------------------------*/
 void pr_out(ADAPTER * a);
 byte pr_dpc(ADAPTER * a);
-void scom_out(ADAPTER * a);
-byte scom_dpc(ADAPTER * a);
 static byte pr_ready(ADAPTER * a);
-static byte scom_ready(ADAPTER * a);
 static byte isdn_rc(ADAPTER *, byte, byte, byte, word, dword, dword);
 static byte isdn_ind(ADAPTER *, byte, byte, byte, PBUFFER *, byte, word);
 /* -----------------------------------------------------------------
@@ -59,11 +56,11 @@
    ----------------------------------------------------------------- */
 #if defined(XDI_USE_XLOG)
 #define XDI_A_NR(_x_) ((byte)(((ISDN_ADAPTER *)(_x_->io))->ANum))
+static void xdi_xlog (byte *msg, word code, int length);
+static byte xdi_xlog_sec = 0;
 #else
 #define XDI_A_NR(_x_) ((byte)0)
 #endif
-byte xdi_xlog_sec = 0;
-void xdi_xlog (byte *msg, word code, int length);
 static void xdi_xlog_rc_event (byte Adapter,
                                byte Id, byte Ch, byte Rc, byte cb, byte type);
 static void xdi_xlog_request (byte Adapter, byte Id,
@@ -345,192 +342,6 @@
   }
   return FALSE;
 }
-byte pr_test_int(ADAPTER * a)
-{
-  return a->ram_in(a,(void *)0x3ffc);
-}
-void pr_clear_int(ADAPTER * a)
-{
-  a->ram_out(a,(void *)0x3ffc,0);
-}
-/*------------------------------------------------------------------*/
-/* output function                                                  */
-/*------------------------------------------------------------------*/
-void scom_out(ADAPTER * a)
-{
-  byte e_no;
-  ENTITY  * this;
-  BUFFERS  * X;
-  word length;
-  word i;
-  word clength;
-  byte more;
-  byte Id;
-  dtrc(dprintf("scom_out"));
-        /* check if the adapter is ready to accept an request:      */
-  e_no = look_req(a);
-  if(!e_no)
-  {
-    dtrc(dprintf("no_req"));
-    return;
-  }
-  if(!scom_ready(a))
-  {
-    dtrc(dprintf("not_ready"));
-    return;
-  }
-  this = entity_ptr(a,e_no);
-  dtrc(dprintf("out:Req=%x,Id=%x,Ch=%x",this->Req,this->Id,this->ReqCh));
-  next_req(a);
-        /* now copy the data from the current data buffer into the  */
-        /* adapters request buffer                                  */
-  length = 0;
-  i = this->XCurrent;
-  X = PTR_X(a, this);
-  while(i<this->XNum && length<270) {
-    clength = MIN((word)(270-length),X[i].PLength-this->XOffset);
-    a->ram_out_buffer(a,
-                      &RAM->XBuffer.P[length],
-                      PTR_P(a,this,&X[i].P[this->XOffset]),
-                      clength);
-    length +=clength;
-    this->XOffset +=clength;
-    if(this->XOffset==X[i].PLength) {
-      this->XCurrent = (byte)++i;
-      this->XOffset = 0;
-    }
-  }
-  a->ram_outw(a, &RAM->XBuffer.length, length);
-  a->ram_out(a, &RAM->ReqId, this->Id);
-  a->ram_out(a, &RAM->ReqCh, this->ReqCh);
-        /* if it's a specific request (no ASSIGN) ...                */
-  if(this->Id &0x1f) {
-        /* if buffers are left in the list of data buffers do       */
-        /* chaining (LL_MDATA, N_MDATA)                             */
-    this->More++;
-    if(i<this->XNum && this->MInd) {
-      a->ram_out(a, &RAM->Req, this->MInd);
-      more = TRUE;
-    }
-    else {
-      this->More |=XMOREF;
-      a->ram_out(a, &RAM->Req, this->Req);
-      more = FALSE;
-      if (a->FlowControlIdTable[this->ReqCh] == this->Id)
-        a->FlowControlSkipTable[this->ReqCh] = TRUE;
-      /*
-         Note that remove request was sent to the card
-         */
-      if (this->Req == REMOVE) {
-        a->misc_flags_table[e_no] |= DIVA_MISC_FLAGS_REMOVE_PENDING;
-      }
-    }
-    if(more) {
-      req_queue(a,this->No);
-    }
-  }
-        /* else it's a ASSIGN                                       */
-  else {
-        /* save the request code used for buffer chaining           */
-    this->MInd = 0;
-    if (this->Id==BLLC_ID) this->MInd = LL_MDATA;
-    if (this->Id==NL_ID   ||
-        this->Id==TASK_ID ||
-        this->Id==MAN_ID
-      ) this->MInd = N_MDATA;
-        /* send the ASSIGN                                          */
-    this->More |=XMOREF;
-    a->ram_out(a, &RAM->Req, this->Req);
-        /* save the reference of the ASSIGN                         */
-    assign_queue(a, this->No, 0);
-  }
-        /* if it is a 'unreturncoded' UREMOVE request, remove the  */
-        /* Id from our table after sending the request             */
-  if(this->Req==UREMOVE && this->Id) {
-    Id = this->Id;
-    e_no = a->IdTable[Id];
-    free_entity(a, e_no);
-    for (i = 0; i < 256; i++)
-    {
-      if (a->FlowControlIdTable[i] == Id)
-        a->FlowControlIdTable[i] = 0;
-    }
-    a->IdTable[Id] = 0;
-    this->Id = 0;
-  }
-}
-static byte scom_ready(ADAPTER * a)
-{
-  if(a->ram_in(a, &RAM->Req)) {
-    if(!a->ReadyInt) {
-      a->ram_inc(a, &RAM->ReadyInt);
-      a->ReadyInt++;
-    }
-    return 0;
-  }
-  return 1;
-}
-/*------------------------------------------------------------------*/
-/* isdn interrupt handler                                           */
-/*------------------------------------------------------------------*/
-byte scom_dpc(ADAPTER * a)
-{
-  byte c;
-        /* if a return code is available ...                        */
-  if(a->ram_in(a, &RAM->Rc)) {
-        /* call return code handler, if it is not our return code   */
-        /* the handler returns 2, if it's the return code to an     */
-        /* ASSIGN the handler returns 1                             */
-    c = isdn_rc(a,
-                a->ram_in(a, &RAM->Rc),
-                a->ram_in(a, &RAM->RcId),
-                a->ram_in(a, &RAM->RcCh),
-                0,
-                /*
-                  Scom Card does not provide extended information
-                  */
-                0, 0);
-    switch(c) {
-    case 0:
-      a->ram_out(a, &RAM->Rc, 0);
-      break;
-    case 1:
-      a->ram_out(a, &RAM->Req, 0);
-      a->ram_out(a, &RAM->Rc, 0);
-      break;
-    case 2:
-      return TRUE;
-    }
-        /* call output function                                     */
-    scom_out(a);
-  }
-  else {
-        /* if an indications is available ...                       */
-    if(a->ram_in(a, &RAM->Ind)) {
-        /* call indication handler, a return value of 2 means chain */
-        /* a return value of 1 means RNR                            */
-      c = isdn_ind(a,
-                   a->ram_in(a, &RAM->Ind),
-                   a->ram_in(a, &RAM->IndId),
-                   a->ram_in(a, &RAM->IndCh),
-                   &RAM->RBuffer,
-                   a->ram_in(a, &RAM->MInd),
-                   a->ram_inw(a, &RAM->MLength));
-      switch(c) {
-      case 0:
-        a->ram_out(a, &RAM->Ind, 0);
-        break;
-      case 1:
-        dtrc(dprintf("RNR"));
-        a->ram_out(a, &RAM->RNR, TRUE);
-        break;
-      case 2:
-        return TRUE;
-      }
-    }
-  }
-  return FALSE;
-}
 byte scom_test_int(ADAPTER * a)
 {
   return a->ram_in(a,(void *)0x3fe);
@@ -539,11 +350,6 @@
 {
   a->ram_out(a,(void *)0x3fe,0);
 }
-void quadro_clear_int(ADAPTER * a)
-{
-  a->ram_out(a,(void *)0x3fe,0);
-  a->ram_out(a,(void *)0x401,0);
-}
 /*------------------------------------------------------------------*/
 /* return code handler                                              */
 /*------------------------------------------------------------------*/
@@ -914,15 +720,15 @@
   }
   return 2;
 }
+#if defined(XDI_USE_XLOG)
 /* -----------------------------------------------------------
    This function works in the same way as xlog on the
    active board
    ----------------------------------------------------------- */
-void xdi_xlog (byte *msg, word code, int length) {
-#if defined(XDI_USE_XLOG)
+static void xdi_xlog (byte *msg, word code, int length) {
   xdi_dbg_xlog ("\x00\x02", msg, code, length);
-#endif
 }
+#endif
 /* -----------------------------------------------------------
     This function writes the information about the Return Code
     processing in the trace buffer. Trace ID is 221.
diff -u linux.orig/drivers/isdn/hardware/eicon/di.h linux/drivers/isdn/hardware/eicon/di.h
--- linux.orig/drivers/isdn/hardware/eicon/di.h	2005-02-11 17:54:29.234656475 +0100
+++ linux/drivers/isdn/hardware/eicon/di.h	2005-02-11 20:41:25.395403308 +0100
@@ -81,13 +81,8 @@
 /*------------------------------------------------------------------*/
 void pr_out(ADAPTER * a);
 byte pr_dpc(ADAPTER * a);
-byte pr_test_int(ADAPTER * a);
-void pr_clear_int(ADAPTER * a);
-void scom_out(ADAPTER * a);
-byte scom_dpc(ADAPTER * a);
 byte scom_test_int(ADAPTER * a);
 void scom_clear_int(ADAPTER * a);
-void quadro_clear_int(ADAPTER * a);
 /*------------------------------------------------------------------*/
 /* OS specific functions used by IDI common code                    */
 /*------------------------------------------------------------------*/
diff -u linux.orig/drivers/isdn/hardware/eicon/diva_didd.c linux/drivers/isdn/hardware/eicon/diva_didd.c
--- linux.orig/drivers/isdn/hardware/eicon/diva_didd.c	2005-02-11 17:52:16.000000000 +0100
+++ linux/drivers/isdn/hardware/eicon/diva_didd.c	2005-02-11 20:41:25.396403189 +0100
@@ -1,4 +1,4 @@
-/* $Id: diva_didd.c,v 1.13.6.1 2004/08/28 20:03:53 armin Exp $
+/* $Id: diva_didd.c,v 1.13.6.4 2005/02/11 19:40:25 armin Exp $
  *
  * DIDD Interface module for Eicon active cards.
  * 
@@ -23,7 +23,7 @@
 #include "divasync.h"
 #include "did_vers.h"
 
-static char *main_revision = "$Revision: 1.13.6.1 $";
+static char *main_revision = "$Revision: 1.13.6.4 $";
 
 static char *DRIVERNAME =
     "Eicon DIVA - DIDD table (http://www.melware.net)";
@@ -140,7 +140,7 @@
 	return (ret);
 }
 
-void DIVA_EXIT_FUNCTION divadidd_exit(void)
+static void DIVA_EXIT_FUNCTION divadidd_exit(void)
 {
 	diddfunc_finit();
 	remove_proc();
diff -u linux.orig/drivers/isdn/hardware/eicon/divamnt.c linux/drivers/isdn/hardware/eicon/divamnt.c
--- linux.orig/drivers/isdn/hardware/eicon/divamnt.c	2005-02-11 17:51:49.000000000 +0100
+++ linux/drivers/isdn/hardware/eicon/divamnt.c	2005-02-11 20:41:25.397403070 +0100
@@ -1,4 +1,4 @@
-/* $Id: divamnt.c,v 1.32.6.9 2005/01/31 12:22:20 armin Exp $
+/* $Id: divamnt.c,v 1.32.6.10 2005/02/11 19:40:25 armin Exp $
  *
  * Driver for Eicon DIVA Server ISDN cards.
  * Maint module
@@ -25,7 +25,7 @@
 #include "divasync.h"
 #include "debug_if.h"
 
-static char *main_revision = "$Revision: 1.32.6.9 $";
+static char *main_revision = "$Revision: 1.32.6.10 $";
 
 static int major;
 
@@ -34,9 +34,9 @@
 MODULE_SUPPORTED_DEVICE("DIVA card driver");
 MODULE_LICENSE("GPL");
 
-int buffer_length = 128;
+static int buffer_length = 128;
 module_param(buffer_length, int, 0);
-unsigned long diva_dbg_mem = 0;
+static unsigned long diva_dbg_mem = 0;
 module_param(diva_dbg_mem, ulong, 0);
 
 static char *DRIVERNAME =
diff -u linux.orig/drivers/isdn/hardware/eicon/io.c linux/drivers/isdn/hardware/eicon/io.c
--- linux.orig/drivers/isdn/hardware/eicon/io.c	2005-02-11 17:50:59.000000000 +0100
+++ linux/drivers/isdn/hardware/eicon/io.c	2005-02-11 20:41:25.401402596 +0100
@@ -36,7 +36,7 @@
 extern ADAPTER * adapter[MAX_ADAPTER];
 extern PISDN_ADAPTER IoAdapters[MAX_ADAPTER];
 void request (PISDN_ADAPTER, ENTITY *);
-void pcm_req (PISDN_ADAPTER, ENTITY *);
+static void pcm_req (PISDN_ADAPTER, ENTITY *);
 /* --------------------------------------------------------------------------
   local functions
   -------------------------------------------------------------------------- */
@@ -118,7 +118,8 @@
           &IoAdapter->Name[0]))
 }
 /*****************************************************************************/
-char *(ExceptionCauseTable[]) =
+#if defined(XDI_USE_XLOG)
+static char *(ExceptionCauseTable[]) =
 {
  "Interrupt",
  "TLB mod /IBOUND",
@@ -153,6 +154,7 @@
  "Reserved 30",
  "VCED"
 } ;
+#endif
 void
 dump_trap_frame (PISDN_ADAPTER IoAdapter, byte __iomem *exceptionFrame)
 {
@@ -496,7 +498,7 @@
 /* --------------------------------------------------------------------------
   XLOG interface
   -------------------------------------------------------------------------- */
-void
+static void
 pcm_req (PISDN_ADAPTER IoAdapter, ENTITY *e)
 {
  diva_os_spin_lock_magic_t OldIrql ;
@@ -848,26 +850,3 @@
  if ( e && e->callback )
   e->callback (e) ;
 }
-/* --------------------------------------------------------------------------
-  routines for aligned reading and writing on RISC
-  -------------------------------------------------------------------------- */
-void outp_words_from_buffer (word __iomem * adr, byte* P, dword len)
-{
-  dword i = 0;
-  word w;
-  while (i < (len & 0xfffffffe)) {
-    w = P[i++];
-    w += (P[i++])<<8;
-    outppw (adr, w);
-  }
-}
-void inp_words_to_buffer (word __iomem * adr, byte* P, dword len)
-{
-  dword i = 0;
-  word w;
-  while (i < (len & 0xfffffffe)) {
-    w = inppw (adr);
-    P[i++] = (byte)(w);
-    P[i++] = (byte)(w>>8);
-  }
-}
diff -u linux.orig/drivers/isdn/hardware/eicon/io.h linux/drivers/isdn/hardware/eicon/io.h
--- linux.orig/drivers/isdn/hardware/eicon/io.h	2005-02-11 17:54:03.000000000 +0100
+++ linux/drivers/isdn/hardware/eicon/io.h	2005-02-11 20:41:25.401402596 +0100
@@ -252,11 +252,6 @@
 #define PR_RAM  ((struct pr_ram *)0)
 #define RAM ((struct dual *)0)
 /* ---------------------------------------------------------------------
-  Functions for port io
-   --------------------------------------------------------------------- */
-void outp_words_from_buffer (word __iomem * adr, byte* P, dword len);
-void inp_words_to_buffer    (word __iomem * adr, byte* P, dword len);
-/* ---------------------------------------------------------------------
   platform specific conversions
    --------------------------------------------------------------------- */
 extern void * PTR_P(ADAPTER * a, ENTITY * e, void * P);
diff -u linux.orig/drivers/isdn/hardware/eicon/message.c linux/drivers/isdn/hardware/eicon/message.c
--- linux.orig/drivers/isdn/hardware/eicon/message.c	2005-02-11 17:52:21.000000000 +0100
+++ linux/drivers/isdn/hardware/eicon/message.c	2005-02-11 20:41:25.407401885 +0100
@@ -55,7 +55,7 @@
 /* and it is not necessary to save it separate for every adapter    */
 /* Macrose defined here have only local meaning                     */
 /*------------------------------------------------------------------*/
-dword diva_xdi_extended_features = 0;
+static dword diva_xdi_extended_features = 0;
 
 #define DIVA_CAPI_USE_CMA                 0x00000001
 #define DIVA_CAPI_XDI_PROVIDES_SDRAM_BAR  0x00000002
@@ -72,11 +72,10 @@
 /* local function prototypes                                        */
 /*------------------------------------------------------------------*/
 
-void group_optimization(DIVA_CAPI_ADAPTER   * a, PLCI   * plci);
-void set_group_ind_mask (PLCI   *plci);
-void set_group_ind_mask_bit (PLCI   *plci, word b);
-void clear_group_ind_mask_bit (PLCI   *plci, word b);
-byte test_group_ind_mask_bit (PLCI   *plci, word b);
+static void group_optimization(DIVA_CAPI_ADAPTER   * a, PLCI   * plci);
+static void set_group_ind_mask (PLCI   *plci);
+static void clear_group_ind_mask_bit (PLCI   *plci, word b);
+static byte test_group_ind_mask_bit (PLCI   *plci, word b);
 void AutomaticLaw(DIVA_CAPI_ADAPTER   *);
 word CapiRelease(word);
 word CapiRegister(word);
@@ -88,7 +87,7 @@
 word api_remove_start(void);
 void api_remove_complete(void);
 
-void plci_remove(PLCI   *);
+static void plci_remove(PLCI   *);
 static void diva_get_extended_adapter_features (DIVA_CAPI_ADAPTER  * a);
 static void diva_ask_for_xdi_sdram_bar (DIVA_CAPI_ADAPTER  *, IDI_SYNC_REQ  *);
 
@@ -100,9 +99,9 @@
 static void sig_ind(PLCI   *);
 static void SendInfo(PLCI   *, dword, byte   * *, byte);
 static void SendSetupInfo(APPL   *, PLCI   *, dword, byte   * *, byte);
-void SendSSExtInd(APPL   *, PLCI   * plci, dword Id, byte   * * parms);
+static void SendSSExtInd(APPL   *, PLCI   * plci, dword Id, byte   * * parms);
 
-void VSwitchReqInd(PLCI   *plci, dword Id, byte   **parms);
+static void VSwitchReqInd(PLCI   *plci, dword Id, byte   **parms);
 
 static void nl_ind(PLCI   *);
 
@@ -254,11 +253,11 @@
 
 
 
-byte remove_started = FALSE;
-PLCI dummy_plci;
+static byte remove_started = FALSE;
+static PLCI dummy_plci;
 
 
-struct _ftable {
+static struct _ftable {
   word command;
   byte * format;
   byte (* function)(dword, word, DIVA_CAPI_ADAPTER   *, PLCI   *, APPL   *, API_PARSE *);
@@ -291,7 +290,7 @@
   {_MANUFACTURER_I|RESPONSE,            "",             manufacturer_res}
 };
 
-byte * cip_bc[29][2] = {
+static byte * cip_bc[29][2] = {
   { "",                     ""                     }, /* 0 */
   { "\x03\x80\x90\xa3",     "\x03\x80\x90\xa2"     }, /* 1 */
   { "\x02\x88\x90",         "\x02\x88\x90"         }, /* 2 */
@@ -324,7 +323,7 @@
   { "\x02\x88\x90",         "\x02\x88\x90"         }  /* 28 */
 };
 
-byte * cip_hlc[29] = {
+static byte * cip_hlc[29] = {
   "",                           /* 0 */
   "",                           /* 1 */
   "",                           /* 2 */
@@ -716,7 +715,7 @@
 /* internal command queue                                           */
 /*------------------------------------------------------------------*/
 
-void init_internal_command_queue (PLCI   *plci)
+static void init_internal_command_queue (PLCI   *plci)
 {
   word i;
 
@@ -729,7 +728,7 @@
 }
 
 
-void start_internal_command (dword Id, PLCI   *plci, t_std_internal_command command_function)
+static void start_internal_command (dword Id, PLCI   *plci, t_std_internal_command command_function)
 {
   word i;
 
@@ -751,7 +750,7 @@
 }
 
 
-void next_internal_command (dword Id, PLCI   *plci)
+static void next_internal_command (dword Id, PLCI   *plci)
 {
   word i;
 
@@ -1048,7 +1047,7 @@
 }
 
 
-void plci_remove(PLCI   * plci)
+static void plci_remove(PLCI   * plci)
 {
 
   if(!plci) {
@@ -1094,7 +1093,7 @@
 /* Application Group function helpers                               */
 /*------------------------------------------------------------------*/
 
-void set_group_ind_mask (PLCI   *plci)
+static void set_group_ind_mask (PLCI   *plci)
 {
   word i;
 
@@ -1102,17 +1101,12 @@
     plci->group_optimization_mask_table[i] = 0xffffffffL;
 }
 
-void set_group_ind_mask_bit (PLCI   *plci, word b)
-{
-  plci->group_optimization_mask_table[b >> 5] |= (1L << (b & 0x1f));
-}
-
-void clear_group_ind_mask_bit (PLCI   *plci, word b)
+static void clear_group_ind_mask_bit (PLCI   *plci, word b)
 {
   plci->group_optimization_mask_table[b >> 5] &= ~(1L << (b & 0x1f));
 }
 
-byte test_group_ind_mask_bit (PLCI   *plci, word b)
+static byte test_group_ind_mask_bit (PLCI   *plci, word b)
 {
   return ((plci->group_optimization_mask_table[b >> 5] & (1L << (b & 0x1f))) != 0);
 }
@@ -1121,7 +1115,7 @@
 /* c_ind_mask operations for arbitrary MAX_APPL                     */
 /*------------------------------------------------------------------*/
 
-void clear_c_ind_mask (PLCI   *plci)
+static void clear_c_ind_mask (PLCI   *plci)
 {
   word i;
 
@@ -1129,7 +1123,7 @@
     plci->c_ind_mask_table[i] = 0;
 }
 
-byte c_ind_mask_empty (PLCI   *plci)
+static byte c_ind_mask_empty (PLCI   *plci)
 {
   word i;
 
@@ -1139,22 +1133,22 @@
   return (i == C_IND_MASK_DWORDS);
 }
 
-void set_c_ind_mask_bit (PLCI   *plci, word b)
+static void set_c_ind_mask_bit (PLCI   *plci, word b)
 {
   plci->c_ind_mask_table[b >> 5] |= (1L << (b & 0x1f));
 }
 
-void clear_c_ind_mask_bit (PLCI   *plci, word b)
+static void clear_c_ind_mask_bit (PLCI   *plci, word b)
 {
   plci->c_ind_mask_table[b >> 5] &= ~(1L << (b & 0x1f));
 }
 
-byte test_c_ind_mask_bit (PLCI   *plci, word b)
+static byte test_c_ind_mask_bit (PLCI   *plci, word b)
 {
   return ((plci->c_ind_mask_table[b >> 5] & (1L << (b & 0x1f))) != 0);
 }
 
-void dump_c_ind_mask (PLCI   *plci)
+static void dump_c_ind_mask (PLCI   *plci)
 {
 static char hex_digit_table[0x10] =
   {'0','1','2','3','4','5','6','7','8','9','a','b','c','d','e','f'};
@@ -6426,7 +6420,7 @@
   return iesent;
 }
 
-void SendSSExtInd(APPL   * appl, PLCI   * plci, dword Id, byte   * * parms)
+static void SendSSExtInd(APPL   * appl, PLCI   * plci, dword Id, byte   * * parms)
 {
   word i;
    /* Format of multi_ssext_parms[i][]:
@@ -14720,71 +14714,6 @@
 
 /*------------------------------------------------------------------*/
 
-/* to be completed */
-void disable_adapter(byte adapter_number)
-{
-  word j, ncci;
-  DIVA_CAPI_ADAPTER   *a;
-  PLCI   *plci;
-  dword Id;
-
-  if ((adapter_number == 0) || (adapter_number > max_adapter) || !adapter[adapter_number-1].request)
-  {
-    dbug(1,dprintf("disable adapter: number %d invalid",adapter_number));
-    return;
-  }
-  dbug(1,dprintf("disable adapter number %d",adapter_number));
-    /* Capi20 starts with Nr. 1, internal field starts with 0 */
-  a = &adapter[adapter_number-1];
-  a->adapter_disabled = TRUE;
-  for(j=0;j<a->max_plci;j++)
-  {
-    if(a->plci[j].Id) /* disconnect logical links */
-    {
-      plci = &a->plci[j];
-      if(plci->channels)
-      {
-        for(ncci=1;ncci<MAX_NCCI+1 && plci->channels;ncci++)
-        {
-          if(a->ncci_plci[ncci]==plci->Id)
-          {
-            Id = (((dword)ncci)<<16)|((word)plci->Id<<8)|a->Id;
-            sendf(plci->appl,_DISCONNECT_B3_I,Id,0,"ws",0,"");
-            plci->channels--;
-          }
-        }
-      }
-
-      if(plci->State!=LISTENING) /* disconnect physical links */
-      {
-        Id = ((word)plci->Id<<8)|a->Id;
-        sendf(plci->appl, _DISCONNECT_I, Id, 0, "w", _L1_ERROR);
-        plci_remove(plci);
-        plci->Sig.Id = 0;
-        plci->NL.Id = 0;
-        plci_remove(plci);
-      }
-    }
-  }
-}
-
-void enable_adapter(byte adapter_number)
-{
-  DIVA_CAPI_ADAPTER   *a;
-
-  if ((adapter_number == 0) || (adapter_number > max_adapter) || !adapter[adapter_number-1].request)
-  {
-    dbug(1,dprintf("enable adapter: number %d invalid",adapter_number));
-    return;
-  }
-  dbug(1,dprintf("enable adapter number %d",adapter_number));
-    /* Capi20 starts with Nr. 1, internal field starts with 0 */
-  a = &adapter[adapter_number-1];
-  a->adapter_disabled = FALSE;
-  listen_check(a);
-}
-
-
 static word CPN_filter_ok(byte   *cpn,DIVA_CAPI_ADAPTER   * a,word offset)
 {
   return 1;
@@ -14800,7 +14729,7 @@
 /* function must be enabled by setting "a->group_optimization_enabled" from the   */
 /* OS specific part (per adapter).                                                */
 /**********************************************************************************/
-void group_optimization(DIVA_CAPI_ADAPTER   * a, PLCI   * plci)
+static void group_optimization(DIVA_CAPI_ADAPTER   * a, PLCI   * plci)
 {
   word i,j,k,busy,group_found;
   dword info_mask_group[MAX_CIP_TYPES];
@@ -14967,7 +14896,7 @@
 
 /* Functions for virtual Switching e.g. Transfer by join, Conference */
 
-void VSwitchReqInd(PLCI   *plci, dword Id, byte   **parms)
+static void VSwitchReqInd(PLCI   *plci, dword Id, byte   **parms)
 {
  word i;
  /* Format of vswitch_t:
diff -u linux.orig/drivers/isdn/hardware/eicon/os_4bri.c linux/drivers/isdn/hardware/eicon/os_4bri.c
--- linux.orig/drivers/isdn/hardware/eicon/os_4bri.c	2005-02-11 17:51:27.000000000 +0100
+++ linux/drivers/isdn/hardware/eicon/os_4bri.c	2005-02-11 20:41:25.407401885 +0100
@@ -1,4 +1,4 @@
-/* $Id: os_4bri.c,v 1.28 2004/03/21 17:26:01 armin Exp $ */
+/* $Id: os_4bri.c,v 1.28.4.4 2005/02/11 19:40:25 armin Exp $ */
 
 #include "platform.h"
 #include "debuglib.h"
@@ -17,8 +17,8 @@
 #include "mi_pc.h"
 #include "dsrv4bri.h"
 
-void *diva_xdiLoadFileFile = NULL;
-dword diva_xdiLoadFileLength = 0;
+static void *diva_xdiLoadFileFile = NULL;
+static dword diva_xdiLoadFileLength = 0;
 
 /*
 **  IMPORTS
@@ -416,8 +416,8 @@
 		if (i) {
 			Slave->serialNo = ((dword) (Slave->ControllerNumber << 24)) |
 					a->xdi_adapter.serialNo;
-		Slave->cardType = a->xdi_adapter.cardType;
-	}
+			Slave->cardType = a->xdi_adapter.cardType;
+		}
 	}
 
 	/*
diff -u linux.orig/drivers/isdn/hardware/eicon/xdi_vers.h linux/drivers/isdn/hardware/eicon/xdi_vers.h
--- linux.orig/drivers/isdn/hardware/eicon/xdi_vers.h	2005-02-11 17:52:55.000000000 +0100
+++ linux/drivers/isdn/hardware/eicon/xdi_vers.h	2005-02-11 20:41:25.413401174 +0100
@@ -1,26 +1,26 @@
-
-/*
- *
-  Copyright (c) Eicon Networks, 2002.
- *
-  This source file is supplied for the use with
-  Eicon Networks range of DIVA Server Adapters.
- *
-  Eicon File Revision :    2.1
- *
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of the GNU General Public License as published by
-  the Free Software Foundation; either version 2, or (at your option)
-  any later version.
- *
-  This program is distributed in the hope that it will be useful,
-  but WITHOUT ANY WARRANTY OF ANY KIND WHATSOEVER INCLUDING ANY
-  implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
-  See the GNU General Public License for more details.
- *
-  You should have received a copy of the GNU General Public License
-  along with this program; if not, write to the Free Software
-  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- *
- */
-static char diva_xdi_common_code_build[] = "102-52"; 
+
+/*
+ *
+  Copyright (c) Eicon Networks, 2002.
+ *
+  This source file is supplied for the use with
+  Eicon Networks range of DIVA Server Adapters.
+ *
+  Eicon File Revision :    2.1
+ *
+  This program is free software; you can redistribute it and/or modify
+  it under the terms of the GNU General Public License as published by
+  the Free Software Foundation; either version 2, or (at your option)
+  any later version.
+ *
+  This program is distributed in the hope that it will be useful,
+  but WITHOUT ANY WARRANTY OF ANY KIND WHATSOEVER INCLUDING ANY
+  implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+  See the GNU General Public License for more details.
+ *
+  You should have received a copy of the GNU General Public License
+  along with this program; if not, write to the Free Software
+  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+static char diva_xdi_common_code_build[] = "102-52"; 
