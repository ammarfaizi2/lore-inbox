Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752032AbWG1Q0O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752032AbWG1Q0O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 12:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752034AbWG1Q0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 12:26:14 -0400
Received: from victor.provo.novell.com ([137.65.250.26]:1163 "EHLO
	victor.provo.novell.com") by vger.kernel.org with ESMTP
	id S1752032AbWG1Q0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 12:26:13 -0400
From: Jan Beulich <jbeulich@novell.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] annotate arch/i386/lib/*.S
Date: Fri, 28 Jul 2006 18:28:10 +0200
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607281828.10546.jbeulich@novell.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add unwind annotations to arch/i386/lib/*.S, and also use the macros
provided by linux/linkage.h where-ever possible.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

--- linux-2.6.18-rc2/arch/i386/lib/checksum.S	2006-07-27 08:50:01.000000000 +0200
+++ 2.6.18-rc2-unwind-info-i386-lib/arch/i386/lib/checksum.S	2006-07-28 16:33:19.000000000 +0200
@@ -25,6 +25,8 @@
  *		2 of the License, or (at your option) any later version.
  */
 
+#include <linux/linkage.h>
+#include <asm/dwarf2.h>
 #include <asm/errno.h>
 				
 /*
@@ -36,8 +38,6 @@ unsigned int csum_partial(const unsigned
  */
 		
 .text
-.align 4
-.globl csum_partial								
 		
 #ifndef CONFIG_X86_USE_PPRO_CHECKSUM
 
@@ -48,9 +48,14 @@ unsigned int csum_partial(const unsigned
 	   * Fortunately, it is easy to convert 2-byte alignment to 4-byte
 	   * alignment for the unrolled loop.
 	   */		
-csum_partial:	
+ENTRY(csum_partial)
+	CFI_STARTPROC
 	pushl %esi
+	CFI_ADJUST_CFA_OFFSET 4
+	CFI_REL_OFFSET esi, 0
 	pushl %ebx
+	CFI_ADJUST_CFA_OFFSET 4
+	CFI_REL_OFFSET ebx, 0
 	movl 20(%esp),%eax	# Function arg: unsigned int sum
 	movl 16(%esp),%ecx	# Function arg: int len
 	movl 12(%esp),%esi	# Function arg: unsigned char *buff
@@ -128,16 +133,27 @@ csum_partial:	
 	roll $8, %eax
 8:
 	popl %ebx
+	CFI_ADJUST_CFA_OFFSET -4
+	CFI_RESTORE ebx
 	popl %esi
+	CFI_ADJUST_CFA_OFFSET -4
+	CFI_RESTORE esi
 	ret
+	CFI_ENDPROC
+ENDPROC(csum_partial)
 
 #else
 
 /* Version for PentiumII/PPro */
 
-csum_partial:
+ENTRY(csum_partial)
+	CFI_STARTPROC
 	pushl %esi
+	CFI_ADJUST_CFA_OFFSET 4
+	CFI_REL_OFFSET esi, 0
 	pushl %ebx
+	CFI_ADJUST_CFA_OFFSET 4
+	CFI_REL_OFFSET ebx, 0
 	movl 20(%esp),%eax	# Function arg: unsigned int sum
 	movl 16(%esp),%ecx	# Function arg: int len
 	movl 12(%esp),%esi	# Function arg:	const unsigned char *buf
@@ -245,8 +261,14 @@ csum_partial:
 	roll $8, %eax
 90: 
 	popl %ebx
+	CFI_ADJUST_CFA_OFFSET -4
+	CFI_RESTORE ebx
 	popl %esi
+	CFI_ADJUST_CFA_OFFSET -4
+	CFI_RESTORE esi
 	ret
+	CFI_ENDPROC
+ENDPROC(csum_partial)
 				
 #endif
 
@@ -278,19 +300,24 @@ unsigned int csum_partial_copy_generic (
 	.long 9999b, 6002f	;	\
 	.previous
 
-.align 4
-.globl csum_partial_copy_generic
-				
 #ifndef CONFIG_X86_USE_PPRO_CHECKSUM
 
 #define ARGBASE 16		
 #define FP		12
 		
-csum_partial_copy_generic:
+ENTRY(csum_partial_copy_generic)
+	CFI_STARTPROC
 	subl  $4,%esp	
+	CFI_ADJUST_CFA_OFFSET 4
 	pushl %edi
+	CFI_ADJUST_CFA_OFFSET 4
+	CFI_REL_OFFSET edi, 0
 	pushl %esi
+	CFI_ADJUST_CFA_OFFSET 4
+	CFI_REL_OFFSET esi, 0
 	pushl %ebx
+	CFI_ADJUST_CFA_OFFSET 4
+	CFI_REL_OFFSET ebx, 0
 	movl ARGBASE+16(%esp),%eax	# sum
 	movl ARGBASE+12(%esp),%ecx	# len
 	movl ARGBASE+4(%esp),%esi	# src
@@ -400,10 +427,19 @@ DST(	movb %cl, (%edi)	)
 .previous
 
 	popl %ebx
+	CFI_ADJUST_CFA_OFFSET -4
+	CFI_RESTORE ebx
 	popl %esi
+	CFI_ADJUST_CFA_OFFSET -4
+	CFI_RESTORE esi
 	popl %edi
+	CFI_ADJUST_CFA_OFFSET -4
+	CFI_RESTORE edi
 	popl %ecx			# equivalent to addl $4,%esp
+	CFI_ADJUST_CFA_OFFSET -4
 	ret	
+	CFI_ENDPROC
+ENDPROC(csum_partial_copy_generic)
 
 #else
 
@@ -421,10 +457,17 @@ DST(	movb %cl, (%edi)	)
 
 #define ARGBASE 12
 		
-csum_partial_copy_generic:
+ENTRY(csum_partial_copy_generic)
+	CFI_STARTPROC
 	pushl %ebx
+	CFI_ADJUST_CFA_OFFSET 4
+	CFI_REL_OFFSET ebx, 0
 	pushl %edi
+	CFI_ADJUST_CFA_OFFSET 4
+	CFI_REL_OFFSET edi, 0
 	pushl %esi
+	CFI_ADJUST_CFA_OFFSET 4
+	CFI_REL_OFFSET esi, 0
 	movl ARGBASE+4(%esp),%esi	#src
 	movl ARGBASE+8(%esp),%edi	#dst	
 	movl ARGBASE+12(%esp),%ecx	#len
@@ -485,9 +528,17 @@ DST(	movb %dl, (%edi)         )
 .previous				
 
 	popl %esi
+	CFI_ADJUST_CFA_OFFSET -4
+	CFI_RESTORE esi
 	popl %edi
+	CFI_ADJUST_CFA_OFFSET -4
+	CFI_RESTORE edi
 	popl %ebx
+	CFI_ADJUST_CFA_OFFSET -4
+	CFI_RESTORE ebx
 	ret
+	CFI_ENDPROC
+ENDPROC(csum_partial_copy_generic)
 				
 #undef ROUND
 #undef ROUND1		
--- linux-2.6.18-rc2/arch/i386/lib/getuser.S	2006-06-18 03:49:35.000000000 +0200
+++ 2.6.18-rc2-unwind-info-i386-lib/arch/i386/lib/getuser.S	2006-07-28 11:07:51.000000000 +0200
@@ -8,6 +8,8 @@
  * return an error value in addition to the "real"
  * return value.
  */
+#include <linux/linkage.h>
+#include <asm/dwarf2.h>
 #include <asm/thread_info.h>
 
 
@@ -24,19 +26,19 @@
  */
 
 .text
-.align 4
-.globl __get_user_1
-__get_user_1:
+ENTRY(__get_user_1)
+	CFI_STARTPROC
 	GET_THREAD_INFO(%edx)
 	cmpl TI_addr_limit(%edx),%eax
 	jae bad_get_user
 1:	movzbl (%eax),%edx
 	xorl %eax,%eax
 	ret
+	CFI_ENDPROC
+ENDPROC(__get_user_1)
 
-.align 4
-.globl __get_user_2
-__get_user_2:
+ENTRY(__get_user_2)
+	CFI_STARTPROC
 	addl $1,%eax
 	jc bad_get_user
 	GET_THREAD_INFO(%edx)
@@ -45,10 +47,11 @@ __get_user_2:
 2:	movzwl -1(%eax),%edx
 	xorl %eax,%eax
 	ret
+	CFI_ENDPROC
+ENDPROC(__get_user_2)
 
-.align 4
-.globl __get_user_4
-__get_user_4:
+ENTRY(__get_user_4)
+	CFI_STARTPROC
 	addl $3,%eax
 	jc bad_get_user
 	GET_THREAD_INFO(%edx)
@@ -57,11 +60,16 @@ __get_user_4:
 3:	movl -3(%eax),%edx
 	xorl %eax,%eax
 	ret
+	CFI_ENDPROC
+ENDPROC(__get_user_4)
 
 bad_get_user:
+	CFI_STARTPROC
 	xorl %edx,%edx
 	movl $-14,%eax
 	ret
+	CFI_ENDPROC
+END(bad_get_user)
 
 .section __ex_table,"a"
 	.long 1b,bad_get_user
--- linux-2.6.18-rc2/arch/i386/lib/putuser.S	2006-06-18 03:49:35.000000000 +0200
+++ 2.6.18-rc2-unwind-info-i386-lib/arch/i386/lib/putuser.S	2006-07-28 11:27:30.000000000 +0200
@@ -8,6 +8,8 @@
  * return an error value in addition to the "real"
  * return value.
  */
+#include <linux/linkage.h>
+#include <asm/dwarf2.h>
 #include <asm/thread_info.h>
 
 
@@ -23,23 +25,28 @@
  * as they get called from within inline assembly.
  */
 
-#define ENTER	pushl %ebx ; GET_THREAD_INFO(%ebx)
-#define EXIT	popl %ebx ; ret
+#define ENTER	CFI_STARTPROC ; \
+		pushl %ebx ; \
+		CFI_ADJUST_CFA_OFFSET 4 ; \
+		CFI_REL_OFFSET ebx, 0 ; \
+		GET_THREAD_INFO(%ebx)
+#define EXIT	popl %ebx ; \
+		CFI_ADJUST_CFA_OFFSET -4 ; \
+		CFI_RESTORE ebx ; \
+		ret ; \
+		CFI_ENDPROC
 
 .text
-.align 4
-.globl __put_user_1
-__put_user_1:
+ENTRY(__put_user_1)
 	ENTER
 	cmpl TI_addr_limit(%ebx),%ecx
 	jae bad_put_user
 1:	movb %al,(%ecx)
 	xorl %eax,%eax
 	EXIT
+ENDPROC(__put_user_1)
 
-.align 4
-.globl __put_user_2
-__put_user_2:
+ENTRY(__put_user_2)
 	ENTER
 	movl TI_addr_limit(%ebx),%ebx
 	subl $1,%ebx
@@ -48,10 +55,9 @@ __put_user_2:
 2:	movw %ax,(%ecx)
 	xorl %eax,%eax
 	EXIT
+ENDPROC(__put_user_2)
 
-.align 4
-.globl __put_user_4
-__put_user_4:
+ENTRY(__put_user_4)
 	ENTER
 	movl TI_addr_limit(%ebx),%ebx
 	subl $3,%ebx
@@ -60,10 +66,9 @@ __put_user_4:
 3:	movl %eax,(%ecx)
 	xorl %eax,%eax
 	EXIT
+ENDPROC(__put_user_4)
 
-.align 4
-.globl __put_user_8
-__put_user_8:
+ENTRY(__put_user_8)
 	ENTER
 	movl TI_addr_limit(%ebx),%ebx
 	subl $7,%ebx
@@ -73,10 +78,16 @@ __put_user_8:
 5:	movl %edx,4(%ecx)
 	xorl %eax,%eax
 	EXIT
+ENDPROC(__put_user_8)
 
 bad_put_user:
+	CFI_STARTPROC simple
+	CFI_DEF_CFA esp, 2*4
+	CFI_OFFSET eip, -1*4
+	CFI_OFFSET ebx, -2*4
 	movl $-14,%eax
 	EXIT
+END(bad_put_user)
 
 .section __ex_table,"a"
 	.long 1b,bad_put_user

