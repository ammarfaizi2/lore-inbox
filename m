Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129977AbRAGV0D>; Sun, 7 Jan 2001 16:26:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130247AbRAGVZy>; Sun, 7 Jan 2001 16:25:54 -0500
Received: from lists.indstate.edu ([139.102.15.43]:59553 "EHLO
	online.indstate.edu") by vger.kernel.org with ESMTP
	id <S129977AbRAGVZo>; Sun, 7 Jan 2001 16:25:44 -0500
From: "Rich Baum" <baumr1@coral.indstate.edu>
To: linux-kernel@vger.kernel.org
Date: Sun, 7 Jan 2001 16:19:50 -0500
MIME-Version: 1.0
Content-type: Multipart/Mixed; boundary=Message-Boundary-8628
Subject: [PATCH] Fix compile warnings in 2.4.0
Reply-to: richbaum@acm.org
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>
Message-ID: <3A589726.5449.291B75@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Message-Boundary-8628
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body

This patch should fix the rest of the warnings about #endif 
statements when using the 20001225 gcc snapshot.  Thanks to 
Keith Owens for providing a script to automate this process.  It got 
the job done sooner and found warnings to fix for non x86 platforms.

Rich


--Message-Boundary-8628
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Text from file 'rb3.patch'

diff -urN -X dontdiff linux/arch/i386/kernel/head.S rb/arch/i386/kernel/head.S
--- linux/arch/i386/kernel/head.S	Wed Nov 29 01:43:39 2000
+++ rb/arch/i386/kernel/head.S	Sun Jan  7 13:33:40 2001
@@ -115,7 +115,7 @@
 	popfl
 	jmp checkCPUtype
 1:
-#endif CONFIG_SMP
+#endif	/* CONFIG_SMP */
 
 /*
  * Clear BSS first so that there are no surprises...
diff -urN -X dontdiff linux/arch/i386/math-emu/control_w.h rb/arch/i386/math-emu/control_w.h
--- linux/arch/i386/math-emu/control_w.h	Thu Jun 29 10:25:27 1995
+++ rb/arch/i386/math-emu/control_w.h	Sun Jan  7 13:33:40 2001
@@ -42,4 +42,4 @@
 /* FULL_PRECISION simulates all exceptions masked */
 #define FULL_PRECISION  (PR_64_BITS | RC_RND | 0x3f)
 
-#endif _CONTROLW_H_
+#endif	/* _CONTROLW_H_ */
diff -urN -X dontdiff linux/arch/i386/math-emu/div_Xsig.S rb/arch/i386/math-emu/div_Xsig.S
--- linux/arch/i386/math-emu/div_Xsig.S	Fri Aug 27 12:18:17 1999
+++ rb/arch/i386/math-emu/div_Xsig.S	Sun Jan  7 13:33:40 2001
@@ -70,7 +70,7 @@
 	.long	0
 FPU_result_1:
 	.long	0
-#endif NON_REENTRANT_FPU
+#endif	/* NON_REENTRANT_FPU */
 
 
 .text
@@ -79,7 +79,7 @@
 	movl	%esp,%ebp
 #ifndef NON_REENTRANT_FPU
 	subl	$28,%esp
-#endif NON_REENTRANT_FPU
+#endif	/* NON_REENTRANT_FPU */
 
 	pushl	%esi
 	pushl	%edi
@@ -91,7 +91,7 @@
 #ifdef PARANOID
 	testl	$0x80000000, XsigH(%ebx)	/* Divisor */
 	je	L_bugged
-#endif PARANOID
+#endif	/* PARANOID */
 
 
 /*---------------------------------------------------------------------------+
@@ -164,7 +164,7 @@
 
 #ifdef PARANOID
 	jb	L_bugged_1
-#endif PARANOID
+#endif	/* PARANOID */
 
 	/* need to subtract another once of the denom */
 	incl	FPU_result_3	/* Correct the answer */
@@ -177,7 +177,7 @@
 #ifdef PARANOID
 	sbbl	$0,FPU_accum_3
 	jne	L_bugged_1	/* Must check for non-zero result here */
-#endif PARANOID
+#endif	/* PARANOID */
 
 /*----------------------------------------------------------------------*/
 /* Half of the main problem is done, there is just a reduced numerator
@@ -207,7 +207,7 @@
 
 #ifdef PARANOID
 	je	L_bugged_2	/* Can't bump the result to 1.0 */
-#endif PARANOID
+#endif	/* PARANOID */
 
 LDo_2nd_div:
 	cmpl	$0,%ecx		/* augmented denom msw */
@@ -230,7 +230,7 @@
 
 #ifdef PARANOID
 	jc	L_bugged_2
-#endif PARANOID
+#endif	/* PARANOID */
 
 	movl	FPU_result_2,%eax	/* Get the result back */
 	mull	XsigL(%ebx)	/* now mul the ls dw of the denom */
@@ -241,14 +241,14 @@
 
 #ifdef PARANOID
 	jc	L_bugged_2
-#endif PARANOID
+#endif	/* PARANOID */
 
 	jz	LDo_3rd_32_bits
 
 #ifdef PARANOID
 	cmpl	$1,FPU_accum_2
 	jne	L_bugged_2
-#endif PARANOID
+#endif	/* PARANOID */
 
 	/* need to subtract another once of the denom */
 	movl	XsigL(%ebx),%eax
@@ -260,14 +260,14 @@
 #ifdef PARANOID
 	jc	L_bugged_2
 	jne	L_bugged_2
-#endif PARANOID
+#endif	/* PARANOID */
 
 	addl	$1,FPU_result_2	/* Correct the answer */
 	adcl	$0,FPU_result_3
 
 #ifdef PARANOID
 	jc	L_bugged_2	/* Must check for non-zero result here */
-#endif PARANOID
+#endif	/* PARANOID */
 
 /*----------------------------------------------------------------------*/
 /* The division is essentially finished here, we just need to perform
@@ -362,4 +362,4 @@
 	call	EXCEPTION
 	pop	%ebx
 	jmp	L_exit
-#endif PARANOID
+#endif	/* PARANOID */
diff -urN -X dontdiff linux/arch/i386/math-emu/errors.c rb/arch/i386/math-emu/errors.c
--- linux/arch/i386/math-emu/errors.c	Tue Dec  9 20:57:09 1997
+++ rb/arch/i386/math-emu/errors.c	Sun Jan  7 13:33:40 2001
@@ -141,7 +141,7 @@
 if ( partial_status & SW_Zero_Div )    printk("SW: divide by zero\n");
 if ( partial_status & SW_Denorm_Op )   printk("SW: denormalized operand\n");
 if ( partial_status & SW_Invalid )     printk("SW: invalid operation\n");
-#endif DEBUGGING
+#endif	/* DEBUGGING */
 
   printk(" SW: b=%d st=%ld es=%d sf=%d cc=%d%d%d%d ef=%d%d%d%d%d%d\n",
 	 partial_status & 0x8000 ? 1 : 0,   /* busy */
@@ -327,7 +327,7 @@
 #ifdef PRINT_MESSAGES
       /* My message from the sponsor */
       printk(FPU_VERSION" "__DATE__" (C) W. Metzenthen.\n");
-#endif PRINT_MESSAGES
+#endif	/* PRINT_MESSAGES */
       
       /* Get a name string for error reporting */
       for (i=0; exception_names[i].type; i++)
@@ -338,7 +338,7 @@
 	{
 #ifdef PRINT_MESSAGES
 	  printk("FP Exception: %s!\n", exception_names[i].name);
-#endif PRINT_MESSAGES
+#endif	/* PRINT_MESSAGES */
 	}
       else
 	printk("FPU emulator: Unknown Exception: 0x%04x!\n", n);
@@ -351,7 +351,7 @@
 #ifdef PRINT_MESSAGES
       else
 	FPU_printall();
-#endif PRINT_MESSAGES
+#endif	/* PRINT_MESSAGES */
 
       /*
        * The 80486 generates an interrupt on the next non-control FPU
@@ -363,7 +363,7 @@
 
 #ifdef __DEBUG__
   math_abort(FPU_info,SIGFPE);
-#endif __DEBUG__
+#endif	/* __DEBUG__ */
 
 }
 
@@ -469,7 +469,7 @@
   else
 #ifdef PARANOID
     if (tagb == TW_NaN)
-#endif PARANOID
+#endif	/* PARANOID */
     {
       signalling = !(b->sigh & 0x40000000);
       x = b;
@@ -481,7 +481,7 @@
       EXCEPTION(EX_INTERNAL|0x113);
       x = &CONST_QNaN;
     }
-#endif PARANOID
+#endif	/* PARANOID */
 
   if ( (!signalling) || (control_word & CW_Invalid) )
     {
diff -urN -X dontdiff linux/arch/i386/math-emu/exception.h rb/arch/i386/math-emu/exception.h
--- linux/arch/i386/math-emu/exception.h	Mon Dec 11 16:34:33 2000
+++ rb/arch/i386/math-emu/exception.h	Sun Jan  7 13:33:40 2001
@@ -18,7 +18,7 @@
 
 #ifndef SW_C1
 #include "fpu_emu.h"
-#endif SW_C1
+#endif	/* SW_C1 */
 
 #define FPU_BUSY        Const_(0x8000)   /* FPU busy bit (8087 compatibility) */
 #define EX_ErrorSummary Const_(0x0080)   /* Error summary status */
@@ -48,6 +48,6 @@
 #define	EXCEPTION(x)	FPU_exception(x)
 #endif
 
-#endif __ASSEMBLY__
+#endif	/* __ASSEMBLY__ */
 
-#endif _EXCEPTION_H_
+#endif	/* _EXCEPTION_H_ */
diff -urN -X dontdiff linux/arch/i386/math-emu/fpu_asm.h rb/arch/i386/math-emu/fpu_asm.h
--- linux/arch/i386/math-emu/fpu_asm.h	Mon Dec 11 16:34:33 2000
+++ rb/arch/i386/math-emu/fpu_asm.h	Sun Jan  7 13:33:40 2001
@@ -29,4 +29,4 @@
 #define	SIGL(x)	SIGL_OFFSET##(x)
 #define	SIGH(x)	4(x)
 
-#endif _FPU_ASM_H_
+#endif	/* _FPU_ASM_H_ */
diff -urN -X dontdiff linux/arch/i386/math-emu/fpu_emu.h rb/arch/i386/math-emu/fpu_emu.h
--- linux/arch/i386/math-emu/fpu_emu.h	Mon Dec 11 16:34:33 2000
+++ rb/arch/i386/math-emu/fpu_emu.h	Sun Jan  7 13:33:40 2001
@@ -88,7 +88,7 @@
 #else
 #  define RE_ENTRANT_CHECK_OFF
 #  define RE_ENTRANT_CHECK_ON
-#endif RE_ENTRANT_CHECKING
+#endif	/* RE_ENTRANT_CHECKING */
 
 #define FWAIT_OPCODE 0x9b
 #define OP_SIZE_PREFIX 0x66
@@ -212,6 +212,6 @@
 #include "fpu_proto.h"
 #endif
 
-#endif __ASSEMBLY__
+#endif	/* __ASSEMBLY__ */
 
-#endif _FPU_EMU_H_
+#endif	/* _FPU_EMU_H_ */
diff -urN -X dontdiff linux/arch/i386/math-emu/fpu_entry.c rb/arch/i386/math-emu/fpu_entry.c
--- linux/arch/i386/math-emu/fpu_entry.c	Mon Jun 19 20:10:44 2000
+++ rb/arch/i386/math-emu/fpu_entry.c	Sun Jan  7 13:33:40 2001
@@ -78,7 +78,7 @@
   fdivr_,   FPU_trigb,  __BAD__, __BAD__, fdiv_i,  __BAD__, fdivp_,  __BAD__,
 };
 
-#endif NO_UNDOC_CODE
+#endif	/* NO_UNDOC_CODE */
 
 
 #define _NONE_ 0   /* Take no special action */
@@ -120,12 +120,12 @@
   _REGI_, _NONE_, _null_, _null_, _REGIi, _null_, _REGIp, _null_
 };
 
-#endif NO_UNDOC_CODE
+#endif	/* NO_UNDOC_CODE */
 
 
 #ifdef RE_ENTRANT_CHECKING
 u_char emulating=0;
-#endif RE_ENTRANT_CHECKING
+#endif	/* RE_ENTRANT_CHECKING */
 
 static int valid_prefix(u_char *Byte, u_char **fpu_eip,
 			overrides *override);
@@ -152,7 +152,7 @@
       printk("ERROR: wm-FPU-emu is not RE-ENTRANT!\n");
     }
   RE_ENTRANT_CHECK_ON;
-#endif RE_ENTRANT_CHECKING
+#endif	/* RE_ENTRANT_CHECKING */
 
   if (!current->used_math)
     {
@@ -251,7 +251,7 @@
 #ifdef PARANOID
       EXCEPTION(EX_INTERNAL|0x128);
       math_abort(FPU_info,SIGILL);
-#endif PARANOID
+#endif	/* PARANOID */
     }
 
   RE_ENTRANT_CHECK_OFF;
@@ -386,7 +386,7 @@
 			/* fdiv or fsub */
 			real_2op_NaN(&loaded_data, loaded_tag, 0, &loaded_data);
 		      else
-#endif PECULIAR_486
+#endif	/* PECULIAR_486 */
 			/* fadd, fdivr, fmul, or fsubr */
 			real_2op_NaN(&loaded_data, loaded_tag, 0, st0_ptr);
 		    }
@@ -497,7 +497,7 @@
 	 to do this: */
       operand_address.offset = 0;
       operand_address.selector = FPU_DS;
-#endif PECULIAR_486
+#endif	/* PECULIAR_486 */
 
       st0_ptr = &st(0);
       st0_tag = FPU_gettag0();
@@ -557,7 +557,7 @@
   RE_ENTRANT_CHECK_OFF;
   FPU_printall();
   RE_ENTRANT_CHECK_ON;
-#endif DEBUG
+#endif	/* DEBUG */
 
   if (FPU_lookahead && !current->need_resched)
     {
@@ -669,7 +669,7 @@
 	__asm__("movl %0,%%esp ; ret": :"g" (((long) info)-4));
 #ifdef PARANOID
       printk("ERROR: wm-FPU-emu math_abort failed!\n");
-#endif PARANOID
+#endif	/* PARANOID */
 }
 
 
@@ -739,7 +739,7 @@
   S387->twd |= 0xffff0000;
   S387->fcs &= ~0xf8000000;
   S387->fos |= 0xffff0000;
-#endif PECULIAR_486
+#endif	/* PECULIAR_486 */
   __copy_to_user(d, &S387->cwd, 7*4);
   RE_ENTRANT_CHECK_ON;
 
diff -urN -X dontdiff linux/arch/i386/math-emu/fpu_etc.c rb/arch/i386/math-emu/fpu_etc.c
--- linux/arch/i386/math-emu/fpu_etc.c	Tue Dec  9 20:57:09 1997
+++ rb/arch/i386/math-emu/fpu_etc.c	Sun Jan  7 13:33:40 2001
@@ -68,7 +68,7 @@
 	      /* This is weird! */
 	      if (getsign(st0_ptr) == SIGN_POS)
 		setcc(SW_C3);
-#endif PECULIAR_486
+#endif	/* PECULIAR_486 */
 	      return;
 	    }
 	  break;
diff -urN -X dontdiff linux/arch/i386/math-emu/fpu_trig.c rb/arch/i386/math-emu/fpu_trig.c
--- linux/arch/i386/math-emu/fpu_trig.c	Thu Nov  4 12:10:22 1999
+++ rb/arch/i386/math-emu/fpu_trig.c	Sun Jan  7 13:33:40 2001
@@ -98,7 +98,7 @@
 	      q++;
 	    }
 	}
-#endif BETTER_THAN_486
+#endif	/* BETTER_THAN_486 */
     }
 #ifdef BETTER_THAN_486
   else
@@ -138,7 +138,7 @@
 	    }
 	}
     }
-#endif BETTER_THAN_486
+#endif	/* BETTER_THAN_486 */
 
   FPU_settag0(st0_tag);
   control_word = old_cw;
@@ -186,7 +186,7 @@
 #ifdef PARANOID
   else
     EXCEPTION(EX_INTERNAL|0x0112);
-#endif PARANOID
+#endif	/* PARANOID */
 }
 
 
@@ -232,7 +232,7 @@
 #ifdef PARANOID
     default:
       EXCEPTION(EX_INTERNAL|0x0112);
-#endif PARANOID
+#endif	/* PARANOID */
     }
 }
 
@@ -463,7 +463,7 @@
 #ifdef PARANOID
   else
     EXCEPTION(EX_INTERNAL | 0x119);
-#endif PARANOID
+#endif	/* PARANOID */
 }
 
 
@@ -716,7 +716,7 @@
 	  set_precision_flag_down();  /* 80486 appears to do this. */
 #else
 	  set_precision_flag_up();  /* Must be up. */
-#endif PECULIAR_486
+#endif	/* PECULIAR_486 */
 	  return 0;
 	}
     }
@@ -1008,7 +1008,7 @@
 	      setcc(SW_C2);
 #else
 	      setcc(0);
-#endif PECULIAR_486
+#endif	/* PECULIAR_486 */
 	      return;
 	    }
 	  cc = SW_C2;
@@ -1114,7 +1114,7 @@
 #ifdef PARANOID
   if ( (st0_tag != TW_NaN) && (st1_tag != TW_NaN) )
       EXCEPTION(EX_INTERNAL | 0x118);
-#endif PARANOID
+#endif	/* PARANOID */
 
   real_2op_NaN(st1_ptr, st1_tag, 0, st1_ptr);
 
@@ -1315,7 +1315,7 @@
 	  sign = getsign(st1_ptr);
 	  if ( FPU_divide_by_zero(1, sign) < 0 )
 	    return;
-#endif PECULIAR_486
+#endif	/* PECULIAR_486 */
 
 	  changesign(st1_ptr);
 	}
@@ -1451,7 +1451,7 @@
 #ifdef PARANOID
   else
     EXCEPTION(EX_INTERNAL | 0x125);
-#endif PARANOID
+#endif	/* PARANOID */
 
   FPU_pop();
   set_precision_flag_up();  /* We do not really know if up or down */
@@ -1542,7 +1542,7 @@
 #ifdef PARANOID
 	  EXCEPTION(EX_INTERNAL | 0x116);
 	  return;
-#endif PARANOID
+#endif	/* PARANOID */
 	}
     }
   else if ( (st0_tag == TAG_Valid) || (st0_tag == TW_Denormal) )
@@ -1560,7 +1560,7 @@
 #else
 		  if ( arith_invalid(1) < 0 )
 		    return;
-#endif PECULIAR_486
+#endif	/* PECULIAR_486 */
 		}
 	      else if ( (st0_tag == TW_Denormal) && (denormal_operand() < 0) )
 		return;
@@ -1583,7 +1583,7 @@
 		  changesign(st1_ptr);
 #else
 		  if ( arith_invalid(1) < 0 ) return;
-#endif PECULIAR_486
+#endif	/* PECULIAR_486 */
 		}
 	      else if ( (st0_tag == TW_Denormal) && (denormal_operand() < 0) )
 		return;
@@ -1618,14 +1618,14 @@
 	  /* This should have higher priority than denormals, but... */
 	  if ( arith_invalid(1) < 0 )  /* log(-infinity) */
 	    return;
-#endif PECULIAR_486
+#endif	/* PECULIAR_486 */
 	  if ( (st1_tag == TW_Denormal) && (denormal_operand() < 0) )
 	    return;
 #ifdef PECULIAR_486
 	  /* Denormal operands actually get higher priority */
 	  if ( arith_invalid(1) < 0 )  /* log(-infinity) */
 	    return;
-#endif PECULIAR_486
+#endif	/* PECULIAR_486 */
 	}
       else if ( st1_tag == TAG_Zero )
 	{
@@ -1654,7 +1654,7 @@
       EXCEPTION(EX_INTERNAL | 0x117);
       return;
     }
-#endif PARANOID
+#endif	/* PARANOID */
 
   FPU_pop();
   return;
diff -urN -X dontdiff linux/arch/i386/math-emu/get_address.c rb/arch/i386/math-emu/get_address.c
--- linux/arch/i386/math-emu/get_address.c	Mon Jun 19 14:56:08 2000
+++ rb/arch/i386/math-emu/get_address.c	Sun Jan  7 13:33:40 2001
@@ -143,7 +143,7 @@
       EXCEPTION(EX_INTERNAL|0x130);
       math_abort(FPU_info,SIGSEGV);
     }
-#endif PARANOID
+#endif	/* PARANOID */
   addr->selector = VM86_REG_(segment);
   return (unsigned long)VM86_REG_(segment) << 4;
 }
@@ -166,7 +166,7 @@
       EXCEPTION(EX_INTERNAL|0x132);
       math_abort(FPU_info,SIGSEGV);
     }
-#endif PARANOID
+#endif	/* PARANOID */
 
   switch ( segment )
     {
diff -urN -X dontdiff linux/arch/i386/math-emu/load_store.c rb/arch/i386/math-emu/load_store.c
--- linux/arch/i386/math-emu/load_store.c	Tue Dec  9 20:57:09 1997
+++ rb/arch/i386/math-emu/load_store.c	Sun Jan  7 13:33:40 2001
@@ -85,7 +85,7 @@
 #ifdef PARANOID
       else
 	EXCEPTION(EX_INTERNAL|0x140);
-#endif PARANOID
+#endif	/* PARANOID */
     }
 
   switch ( type_table[type] )
@@ -112,7 +112,7 @@
     default:
       EXCEPTION(EX_INTERNAL|0x141);
       return 0;
-#endif PARANOID
+#endif	/* PARANOID */
     }
 
   switch ( type )
@@ -217,7 +217,7 @@
 	partial_status &= ~(SW_Summary | SW_Backward);
 #ifdef PECULIAR_486
       control_word |= 0x40;  /* An 80486 appears to always set this bit */
-#endif PECULIAR_486
+#endif	/* PECULIAR_486 */
       return 1;
     case 025:      /* fld m80real */
       clear_C1();
diff -urN -X dontdiff linux/arch/i386/math-emu/poly.h rb/arch/i386/math-emu/poly.h
--- linux/arch/i386/math-emu/poly.h	Thu Nov  4 12:10:22 1999
+++ rb/arch/i386/math-emu/poly.h	Sun Jan  7 13:33:40 2001
@@ -118,4 +118,4 @@
                :"=g" (*x):"g" (x):"si","ax","cx");
 }
 
-#endif _POLY_H
+#endif	/* _POLY_H */
diff -urN -X dontdiff linux/arch/i386/math-emu/poly_2xm1.c rb/arch/i386/math-emu/poly_2xm1.c
--- linux/arch/i386/math-emu/poly_2xm1.c	Tue Dec  9 20:57:09 1997
+++ rb/arch/i386/math-emu/poly_2xm1.c	Sun Jan  7 13:33:40 2001
@@ -67,7 +67,7 @@
       EXCEPTION(EX_INTERNAL|0x127);
       return 1;
     }
-#endif PARANOID
+#endif	/* PARANOID */
 
   argSignif.lsw = 0;
   XSIG_LL(argSignif) = Xll = significand(arg);
diff -urN -X dontdiff linux/arch/i386/math-emu/poly_atan.c rb/arch/i386/math-emu/poly_atan.c
--- linux/arch/i386/math-emu/poly_atan.c	Tue Dec  9 20:57:09 1997
+++ rb/arch/i386/math-emu/poly_atan.c	Sun Jan  7 13:33:40 2001
@@ -124,7 +124,7 @@
 	      EXCEPTION(EX_INTERNAL|0x104);  /* There must be a logic error */
 	      return;
 	    }
-#endif PARANOID
+#endif	/* PARANOID */
 	  argSignif.msw = 0;   /* Make the transformed arg -> 0.0 */
 	}
       else
diff -urN -X dontdiff linux/arch/i386/math-emu/poly_l2.c rb/arch/i386/math-emu/poly_l2.c
--- linux/arch/i386/math-emu/poly_l2.c	Tue Dec  9 20:57:09 1997
+++ rb/arch/i386/math-emu/poly_l2.c	Sun Jan  7 13:33:40 2001
@@ -157,7 +157,7 @@
 #else
 	  if ( arith_invalid(1) < 0 )
 	    return 1;
-#endif PECULIAR_486
+#endif	/* PECULIAR_486 */
 	}
 
       /* 80486 appears to do this */
@@ -243,7 +243,7 @@
 	  /* The argument is too large */
 	}
     }
-#endif PECULIAR_486
+#endif	/* PECULIAR_486 */
 
   arg_signif.lsw = argSignif.lsw; XSIG_LL(arg_signif) = XSIG_LL(argSignif);
   adj = norm_Xsig(&argSignif);
diff -urN -X dontdiff linux/arch/i386/math-emu/poly_sin.c rb/arch/i386/math-emu/poly_sin.c
--- linux/arch/i386/math-emu/poly_sin.c	Thu Nov  4 12:10:22 1999
+++ rb/arch/i386/math-emu/poly_sin.c	Sun Jan  7 13:33:40 2001
@@ -199,7 +199,7 @@
     {
       EXCEPTION(EX_INTERNAL|0x150);
     }
-#endif PARANOID
+#endif	/* PARANOID */
 
 }
 
@@ -224,7 +224,7 @@
       FPU_copy_to_reg0(&CONST_QNaN, TAG_Special);
       return;
     }
-#endif PARANOID
+#endif	/* PARANOID */
 
   exponent = exponent(st0_ptr);
 
@@ -392,6 +392,6 @@
     {
       EXCEPTION(EX_INTERNAL|0x151);
     }
-#endif PARANOID
+#endif	/* PARANOID */
 
 }
diff -urN -X dontdiff linux/arch/i386/math-emu/poly_tan.c rb/arch/i386/math-emu/poly_tan.c
--- linux/arch/i386/math-emu/poly_tan.c	Wed Jul  5 12:56:13 2000
+++ rb/arch/i386/math-emu/poly_tan.c	Sun Jan  7 13:33:40 2001
@@ -66,7 +66,7 @@
 #ifdef PARANOID
   if ( signnegative(st0_ptr) )	/* Can't hack a number < 0.0 */
     { arith_invalid(0); return; }  /* Need a positive number */
-#endif PARANOID
+#endif	/* PARANOID */
 
   /* Split the problem into two domains, smaller and larger than pi/4 */
   if ( (exponent == 0) || ((exponent == -1) && (st0_ptr->sigh > 0xc90fdaa2)) )
diff -urN -X dontdiff linux/arch/i386/math-emu/reg_compare.c rb/arch/i386/math-emu/reg_compare.c
--- linux/arch/i386/math-emu/reg_compare.c	Tue Dec  9 20:57:09 1997
+++ rb/arch/i386/math-emu/reg_compare.c	Sun Jan  7 13:33:40 2001
@@ -136,7 +136,7 @@
 #ifdef PARANOID
   if (!(st0_ptr->sigh & 0x80000000)) EXCEPTION(EX_Invalid);
   if (!(b->sigh & 0x80000000)) EXCEPTION(EX_Invalid);
-#endif PARANOID
+#endif	/* PARANOID */
 
   diff = exp0 - expb;
   if ( diff == 0 )
@@ -203,7 +203,7 @@
 	EXCEPTION(EX_INTERNAL|0x121);
 	f = SW_C3 | SW_C2 | SW_C0;
 	break;
-#endif PARANOID
+#endif	/* PARANOID */
       }
   setcc(f);
   if (c & COMP_Denormal)
@@ -255,7 +255,7 @@
 	EXCEPTION(EX_INTERNAL|0x122);
 	f = SW_C3 | SW_C2 | SW_C0;
 	break;
-#endif PARANOID
+#endif	/* PARANOID */
       }
   setcc(f);
   if (c & COMP_Denormal)
@@ -312,7 +312,7 @@
 	EXCEPTION(EX_INTERNAL|0x123);
 	f = SW_C3 | SW_C2 | SW_C0;
 	break;
-#endif PARANOID
+#endif	/* PARANOID */
       }
   setcc(f);
   if (c & COMP_Denormal)
diff -urN -X dontdiff linux/arch/i386/math-emu/reg_constant.h rb/arch/i386/math-emu/reg_constant.h
--- linux/arch/i386/math-emu/reg_constant.h	Mon Dec 11 16:34:34 2000
+++ rb/arch/i386/math-emu/reg_constant.h	Sun Jan  7 13:33:40 2001
@@ -28,4 +28,4 @@
 extern FPU_REG const CONST_MINF;
 extern FPU_REG const CONST_QNaN;
 
-#endif _REG_CONSTANT_H_
+#endif	/* _REG_CONSTANT_H_ */
diff -urN -X dontdiff linux/arch/i386/math-emu/reg_divide.c rb/arch/i386/math-emu/reg_divide.c
--- linux/arch/i386/math-emu/reg_divide.c	Tue Dec  9 20:57:09 1997
+++ rb/arch/i386/math-emu/reg_divide.c	Sun Jan  7 13:33:40 2001
@@ -201,6 +201,6 @@
       EXCEPTION(EX_INTERNAL|0x102);
       return FPU_Exception;
     }
-#endif PARANOID
+#endif	/* PARANOID */
 
 }
diff -urN -X dontdiff linux/arch/i386/math-emu/reg_ld_str.c rb/arch/i386/math-emu/reg_ld_str.c
--- linux/arch/i386/math-emu/reg_ld_str.c	Sun Jan 25 14:01:48 1998
+++ rb/arch/i386/math-emu/reg_ld_str.c	Sun Jan  7 13:33:40 2001
@@ -439,7 +439,7 @@
 		 converts to decide underflow. */
 	      if ( !((tmp.sigh == 0x00100000) && (tmp.sigl == 0) &&
 		  (st0_ptr->sigl & 0x000007ff)) )
-#endif PECULIAR_486
+#endif	/* PECULIAR_486 */
 		{
 		  EXCEPTION(EX_Underflow);
 		  /* This is a special case: see sec 16.2.5.1 of
@@ -559,7 +559,7 @@
 	  /* Underflow has priority. */
 	  if ( control_word & CW_Underflow )
 	    denormal_operand();
-#endif PECULIAR_486
+#endif	/* PECULIAR_486 */
 	  reg_copy(st0_ptr, &tmp);
 	  goto denormal_arg;
 	}
@@ -659,7 +659,7 @@
 		 converts to decide underflow. */
 	      if ( !((tmp.sigl == 0x00800000) &&
 		  ((st0_ptr->sigh & 0x000000ff) || st0_ptr->sigl)) )
-#endif PECULIAR_486
+#endif	/* PECULIAR_486 */
 		{
 		  EXCEPTION(EX_Underflow);
 		  /* This is a special case: see sec 16.2.5.1 of
@@ -776,7 +776,7 @@
 	  /* Underflow has priority. */
 	  if ( control_word & CW_Underflow )
 	    denormal_operand();
-#endif PECULIAR_486
+#endif	/* PECULIAR_486 */
 	  goto denormal_arg;
 	}
       else if (st0_tag == TW_Infinity)
@@ -1221,7 +1221,7 @@
 
 #ifdef PECULIAR_486
   control_word &= ~0xe080;
-#endif PECULIAR_486
+#endif	/* PECULIAR_486 */
 
   top = (partial_status >> SW_Top_Shift) & 7;
 
@@ -1303,7 +1303,7 @@
       FPU_put_user(control_word & ~0xe080, (unsigned long *) d);
 #else
       FPU_put_user(control_word, (unsigned short *) d);
-#endif PECULIAR_486
+#endif	/* PECULIAR_486 */
       FPU_put_user(status_word(), (unsigned short *) (d+2));
       FPU_put_user(fpu_tag_word, (unsigned short *) (d+4));
       FPU_put_user(instruction_address.offset, (unsigned short *) (d+6));
@@ -1335,7 +1335,7 @@
       fpu_tag_word |= 0xffff0000;
       I387.soft.fcs &= ~0xf8000000;
       I387.soft.fos |= 0xffff0000;
-#endif PECULIAR_486
+#endif	/* PECULIAR_486 */
       __copy_to_user(d, &control_word, 7*4);
       RE_ENTRANT_CHECK_ON;
       d += 0x1c;
diff -urN -X dontdiff linux/arch/i386/math-emu/reg_mul.c rb/arch/i386/math-emu/reg_mul.c
--- linux/arch/i386/math-emu/reg_mul.c	Wed Jun 24 16:30:08 1998
+++ rb/arch/i386/math-emu/reg_mul.c	Sun Jan  7 13:33:40 2001
@@ -126,6 +126,6 @@
       EXCEPTION(EX_INTERNAL|0x102);
       return FPU_Exception;
     }
-#endif PARANOID
+#endif	/* PARANOID */
 
 }
diff -urN -X dontdiff linux/arch/i386/math-emu/reg_round.S rb/arch/i386/math-emu/reg_round.S
--- linux/arch/i386/math-emu/reg_round.S	Thu Nov  4 12:10:22 1999
+++ rb/arch/i386/math-emu/reg_round.S	Sun Jan  7 13:33:40 2001
@@ -100,7 +100,7 @@
 	.byte	0
 FPU_denormal:
 	.byte	0
-#endif NON_REENTRANT_FPU
+#endif	/* NON_REENTRANT_FPU */
 
 
 .text
@@ -126,13 +126,13 @@
 
 #ifndef NON_REENTRANT_FPU
 	pushl	%ebx		/* adjust the stack pointer */
-#endif NON_REENTRANT_FPU
+#endif	/* NON_REENTRANT_FPU */
 
 #ifdef PARANOID
 /* Cannot use this here yet */
 /*	orl	%eax,%eax */
 /*	jns	L_entry_bugged */
-#endif PARANOID
+#endif	/* PARANOID */
 
 	cmpw	EXP_UNDER,EXP(%edi)
 	jle	L_Make_denorm			/* The number is a de-normal */
@@ -160,12 +160,12 @@
 	je	LRound_To_64
 #ifdef PARANOID
 	jmp	L_bugged_denorm_486
-#endif PARANOID
+#endif	/* PARANOID */
 #else
 #ifdef PARANOID
 	jmp	L_bugged_denorm	/* There is no bug, just a bad control word */
-#endif PARANOID
-#endif PECULIAR_486
+#endif	/* PARANOID */
+#endif	/* PECULIAR_486 */
 
 
 /* Round etc to 24 bit precision */
@@ -186,7 +186,7 @@
 
 #ifdef PARANOID
 	jmp	L_bugged_round24
-#endif PARANOID
+#endif	/* PARANOID */
 
 LUp_24:
 	cmpb	SIGN_POS,PARAM5
@@ -266,7 +266,7 @@
 
 #ifdef PARANOID
 	jmp	L_bugged_round53
-#endif PARANOID
+#endif	/* PARANOID */
 
 LUp_53:
 	cmpb	SIGN_POS,PARAM5
@@ -340,7 +340,7 @@
 
 #ifdef PARANOID
 	jmp	L_bugged_round64
-#endif PARANOID
+#endif	/* PARANOID */
 
 LUp_64:
 	cmpb	SIGN_POS,PARAM5
@@ -430,7 +430,7 @@
 
 #ifndef NON_REENTRANT_FPU
 	popl	%ebx		/* adjust the stack pointer */
-#endif NON_REENTRANT_FPU
+#endif	/* NON_REENTRANT_FPU */
 
 fpu_Arith_exit:
 	popl	%ebx
@@ -570,7 +570,7 @@
 	/* But check it... just in case. */
 	cmpw	EXP_UNDER+1,EXP(%edi)
 	jne	L_norm_bugged
-#endif PARANOID
+#endif	/* PARANOID */
 
 #ifdef PECULIAR_486
 	/*
@@ -586,7 +586,7 @@
 #else
 	orl	%eax,%eax		/* ms bits */
 	js	L_Normalised		/* No longer a denormal */
-#endif PECULIAR_486
+#endif	/* PECULIAR_486 */
 
 	jnz	LDenormal_adj_exponent
 
@@ -673,7 +673,7 @@
 	call	EXCEPTION
 	popl	%ebx
 	jmp	L_exception_exit
-#endif PECULIAR_486
+#endif	/* PECULIAR_486 */
 
 L_bugged_round24:
 	pushl	EX_INTERNAL|0x231
@@ -706,4 +706,4 @@
 L_exception_exit:
 	mov	$-1,%eax
 	jmp	fpu_reg_round_special_exit
-#endif PARANOID
+#endif	/* PARANOID */
diff -urN -X dontdiff linux/arch/i386/math-emu/reg_u_add.S rb/arch/i386/math-emu/reg_u_add.S
--- linux/arch/i386/math-emu/reg_u_add.S	Tue Dec  9 20:57:09 1997
+++ rb/arch/i386/math-emu/reg_u_add.S	Sun Jan  7 13:33:40 2001
@@ -72,7 +72,7 @@
 
 	testl	$0x80000000,SIGH(%esi)
 	je	L_bugged
-#endif PARANOID
+#endif	/* PARANOID */
 
 /* The number to be shifted is in %eax:%ebx:%edx */
 	cmpw	$32,%cx		/* shrd only works for 0..31 bits */
@@ -164,4 +164,4 @@
 	popl	%esi
 	leave
 	ret
-#endif PARANOID
+#endif	/* PARANOID */
diff -urN -X dontdiff linux/arch/i386/math-emu/reg_u_div.S rb/arch/i386/math-emu/reg_u_div.S
--- linux/arch/i386/math-emu/reg_u_div.S	Fri Aug 27 12:18:17 1999
+++ rb/arch/i386/math-emu/reg_u_div.S	Sun Jan  7 13:33:40 2001
@@ -67,7 +67,7 @@
 	.long	0
 FPU_ovfl_flag:
 	.byte	0
-#endif NON_REENTRANT_FPU
+#endif	/* NON_REENTRANT_FPU */
 
 #define REGA	PARAM1
 #define REGB	PARAM2
@@ -79,7 +79,7 @@
 	movl	%esp,%ebp
 #ifndef NON_REENTRANT_FPU
 	subl	$28,%esp
-#endif NON_REENTRANT_FPU
+#endif	/* NON_REENTRANT_FPU */
 
 	pushl	%esi
 	pushl	%edi
@@ -112,7 +112,7 @@
 /*	je	L_bugged */
 	testl	$0x80000000, SIGH(%ebx)	/* Divisor */
 	je	L_bugged
-#endif PARANOID
+#endif	/* PARANOID */
 
 /* Check if the divisor can be treated as having just 32 bits */
 	cmpl	$0,SIGL(%ebx)
@@ -248,7 +248,7 @@
 
 #ifdef PARANOID
 	jb	L_bugged_1
-#endif PARANOID
+#endif	/* PARANOID */
 
 	/* need to subtract another once of the denom */
 	incl	FPU_result_2	/* Correct the answer */
@@ -261,7 +261,7 @@
 #ifdef PARANOID
 	sbbl	$0,FPU_accum_3
 	jne	L_bugged_1	/* Must check for non-zero result here */
-#endif PARANOID
+#endif	/* PARANOID */
 
 /*----------------------------------------------------------------------*/
 /* Half of the main problem is done, there is just a reduced numerator
@@ -291,7 +291,7 @@
 
 #ifdef PARANOID
 	je	L_bugged_2	/* Can't bump the result to 1.0 */
-#endif PARANOID
+#endif	/* PARANOID */
 
 LDo_2nd_div:
 	cmpl	$0,%ecx		/* augmented denom msw */
@@ -314,7 +314,7 @@
 
 #ifdef PARANOID
 	jc	L_bugged_2
-#endif PARANOID
+#endif	/* PARANOID */
 
 	movl	FPU_result_1,%eax	/* Get the result back */
 	mull	SIGL(%ebx)	/* now mul the ls dw of the denom */
@@ -325,14 +325,14 @@
 
 #ifdef PARANOID
 	jc	L_bugged_2
-#endif PARANOID
+#endif	/* PARANOID */
 
 	jz	LDo_3rd_32_bits
 
 #ifdef PARANOID
 	cmpl	$1,FPU_accum_2
 	jne	L_bugged_2
-#endif PARANOID
+#endif	/* PARANOID */
 
 	/* need to subtract another once of the denom */
 	movl	SIGL(%ebx),%eax
@@ -344,14 +344,14 @@
 #ifdef PARANOID
 	jc	L_bugged_2
 	jne	L_bugged_2
-#endif PARANOID
+#endif	/* PARANOID */
 
 	addl	$1,FPU_result_1	/* Correct the answer */
 	adcl	$0,FPU_result_2
 
 #ifdef PARANOID
 	jc	L_bugged_2	/* Must check for non-zero result here */
-#endif PARANOID
+#endif	/* PARANOID */
 
 /*----------------------------------------------------------------------*/
 /* The division is essentially finished here, we just need to perform
@@ -470,4 +470,4 @@
 
 	leave
 	ret
-#endif PARANOID
+#endif	/* PARANOID */
diff -urN -X dontdiff linux/arch/i386/math-emu/reg_u_mul.S rb/arch/i386/math-emu/reg_u_mul.S
--- linux/arch/i386/math-emu/reg_u_mul.S	Tue Dec  9 20:57:09 1997
+++ rb/arch/i386/math-emu/reg_u_mul.S	Sun Jan  7 13:33:40 2001
@@ -40,7 +40,7 @@
 	.long	0
 FPU_accum_1:
 	.long	0
-#endif NON_REENTRANT_FPU
+#endif	/* NON_REENTRANT_FPU */
 
 
 .text
@@ -49,7 +49,7 @@
 	movl	%esp,%ebp
 #ifndef NON_REENTRANT_FPU
 	subl	$8,%esp
-#endif NON_REENTRANT_FPU
+#endif	/* NON_REENTRANT_FPU */
 
 	pushl	%esi
 	pushl	%edi
@@ -63,7 +63,7 @@
 	jz	L_bugged
 	testl	$0x80000000,SIGH(%edi)
 	jz	L_bugged
-#endif PARANOID
+#endif	/* PARANOID */
 
 	xorl	%ecx,%ecx
 	xorl	%ebx,%ebx
@@ -144,5 +144,5 @@
 	popl	%esi
 	leave
 	ret
-#endif PARANOID
+#endif	/* PARANOID */
 
diff -urN -X dontdiff linux/arch/i386/math-emu/reg_u_sub.S rb/arch/i386/math-emu/reg_u_sub.S
--- linux/arch/i386/math-emu/reg_u_sub.S	Tue Dec  9 20:57:09 1997
+++ rb/arch/i386/math-emu/reg_u_sub.S	Sun Jan  7 13:33:40 2001
@@ -54,7 +54,7 @@
 
 	testl	$0x80000000,SIGH(%esi)
 	je	L_bugged_2
-#endif PARANOID
+#endif	/* PARANOID */
 
 /*--------------------------------------+
  |	Form a register holding the     |
@@ -165,7 +165,7 @@
 #ifdef PARANOID
 	/* We can never get a borrow */
 	jc	L_bugged
-#endif PARANOID
+#endif	/* PARANOID */
 
 /*--------------------------------------+
  |	Normalize the result		|
@@ -199,7 +199,7 @@
 #ifdef PARANOID
 	orl	%edx,%edx
 	jnz	L_bugged_3
-#endif PARANOID
+#endif	/* PARANOID */
 
 	/* The result is zero */
 	movw	$0,EXP(%edi)		/* exponent */
@@ -262,7 +262,7 @@
 L_error_exit:
 	movl	$-1,%eax
 
-#endif PARANOID
+#endif	/* PARANOID */
 
 L_exit:
 	popl	%ebx
diff -urN -X dontdiff linux/arch/i386/math-emu/status_w.h rb/arch/i386/math-emu/status_w.h
--- linux/arch/i386/math-emu/status_w.h	Mon Dec 11 16:34:33 2000
+++ rb/arch/i386/math-emu/status_w.h	Sun Jan  7 13:33:40 2001
@@ -58,8 +58,8 @@
 #  define clear_C1()  { partial_status &= ~SW_C1; }
 # else
 #  define clear_C1()
-#endif PECULIAR_486
+#endif	/* PECULIAR_486 */
 
-#endif __ASSEMBLY__
+#endif	/* __ASSEMBLY__ */
 
-#endif _STATUS_H_
+#endif	/* _STATUS_H_ */
diff -urN -X dontdiff linux/arch/i386/math-emu/wm_sqrt.S rb/arch/i386/math-emu/wm_sqrt.S
--- linux/arch/i386/math-emu/wm_sqrt.S	Tue Dec  9 20:57:09 1997
+++ rb/arch/i386/math-emu/wm_sqrt.S	Sun Jan  7 13:33:40 2001
@@ -70,7 +70,7 @@
 	.long	0
 FPU_fsqrt_arg_0:
 	.long	0		/* ls word, at most the ms bit is set */
-#endif NON_REENTRANT_FPU
+#endif	/* NON_REENTRANT_FPU */
 
 
 .text
@@ -79,7 +79,7 @@
 	movl	%esp,%ebp
 #ifndef NON_REENTRANT_FPU
 	subl	$28,%esp
-#endif NON_REENTRANT_FPU
+#endif	/* NON_REENTRANT_FPU */
 	pushl	%esi
 	pushl	%edi
 	pushl	%ebx
@@ -210,7 +210,7 @@
 /* It should be possible to get here only if the arg is ffff....ffff */
 	cmp	$0xffffffff,FPU_fsqrt_arg_1
 	jnz	sqrt_stage_2_error
-#endif PARANOID
+#endif	/* PARANOID */
 
 /* The best rounded result. */
 	xorl	%eax,%eax
@@ -224,7 +224,7 @@
 sqrt_stage_2_error:
 	pushl	EX_INTERNAL|0x213
 	call	EXCEPTION
-#endif PARANOID
+#endif	/* PARANOID */
 
 sqrt_stage_2_done:
 
@@ -279,7 +279,7 @@
 	call	EXCEPTION
 
 sqrt_stage_3_no_error:
-#endif PARANOID
+#endif	/* PARANOID */
 
 	movl	FPU_accum_2,%edx
 	movl	FPU_accum_1,%eax
@@ -385,7 +385,7 @@
 	call	EXCEPTION
 
 sqrt_near_exact_ok:
-#endif PARANOID
+#endif	/* PARANOID */
 
 	or	%ebx,%ebx
 	js	sqrt_near_exact_small
@@ -445,7 +445,7 @@
 	call	EXCEPTION
 
 sqrt_more_prec_ok:
-#endif PARANOID
+#endif	/* PARANOID */
 
 	or	%ebx,%ebx
 	js	sqrt_more_prec_small
diff -urN -X dontdiff linux/arch/m68k/ifpsp060/src/fplsp.S rb/arch/m68k/ifpsp060/src/fplsp.S
--- linux/arch/m68k/ifpsp060/src/fplsp.S	Fri Dec 29 17:07:20 2000
+++ rb/arch/m68k/ifpsp060/src/fplsp.S	Sun Jan  7 13:33:47 2001
@@ -9364,7 +9364,7 @@
 #                   R := X, go to Step 4.				#
 #                else							#
 #                   R := 2^(-L)X, j := L.				#
-#                endif							#
+#                endif	/* # */
 #									#
 #       Step 3.  Perform MOD(X,Y)					#
 #            3.1 If R = Y, go to Step 9.				#
diff -urN -X dontdiff linux/arch/m68k/ifpsp060/src/fpsp.S rb/arch/m68k/ifpsp060/src/fpsp.S
--- linux/arch/m68k/ifpsp060/src/fpsp.S	Fri Dec 29 17:07:20 2000
+++ rb/arch/m68k/ifpsp060/src/fpsp.S	Sun Jan  7 13:33:47 2001
@@ -9723,7 +9723,7 @@
 #                   R := X, go to Step 4.				#
 #                else							#
 #                   R := 2^(-L)X, j := L.				#
-#                endif							#
+#                endif	/* # */
 #									#
 #       Step 3.  Perform MOD(X,Y)					#
 #            3.1 If R = Y, go to Step 9.				#
diff -urN -X dontdiff linux/arch/m68k/kernel/head.S rb/arch/m68k/kernel/head.S
--- linux/arch/m68k/kernel/head.S	Wed Jan 26 15:44:20 2000
+++ rb/arch/m68k/kernel/head.S	Sun Jan  7 13:33:48 2001
@@ -144,7 +144,7 @@
  * ---------
  *	This algorithm will print out the page tables of the system as
  * appropriate for an 030 or an 040.  This is useful for debugging purposes
- * and as such is enclosed in #ifdef MMU_PRINT/#endif clauses.
+ * and as such is enclosed in #ifdef MMU_PRINT/#endif	/* clauses. */
  *
  * ######################################################################
  *
@@ -152,7 +152,7 @@
  * ------------
  *	The console is also able to be turned off.  The console in head.S
  * is specifically for debugging and can be very useful.  It is surrounded by
- * #ifdef CONSOLE/#endif clauses so it doesn't have to ship in known-good
+ * #ifdef CONSOLE/#endif	/* clauses so it doesn't have to ship in known-good */
  * kernels.  It's basic algorithm is to determine the size of the screen
  * (in height/width and bit depth) and then use that information for
  * displaying an 8x8 font or an 8x16 (widthxheight).  I prefer the 8x8 for
@@ -1569,7 +1569,7 @@
 	putc	'\n'
 #if 0
 	/*
-	 * The following #if/#endif block is a tight algorithm for dumping the 040
+	 * The following #if/#endif	/* block is a tight algorithm for dumping the 040 */
 	 * MMU Map in gory detail.  It really isn't that practical unless the
 	 * MMU Map algorithm appears to go awry and you need to debug it at the
 	 * entry per entry level.
@@ -3047,7 +3047,7 @@
 	moveml	%sp@+,%d0-%d7/%a2-%a6
 	jbra	L(serial_putc_done)
 2:
-#endif CONFIG_MVME16x
+#endif	/* CONFIG_MVME16x */
 
 #ifdef CONFIG_BVME6000
 	is_not_bvme6000(2f)
diff -urN -X dontdiff linux/arch/mips/cobalt/int-handler.S rb/arch/mips/cobalt/int-handler.S
--- linux/arch/mips/cobalt/int-handler.S	Mon Jul 10 00:18:15 2000
+++ rb/arch/mips/cobalt/int-handler.S	Sun Jan  7 13:33:44 2001
@@ -38,7 +38,7 @@
 	
 		 andi	t1,t0,STATUSF_IP4
 		bnez	t1,ll_ethernet1_irq
-/* #endif  */
+/* #endif	/* */ */
 		 andi	t1,t0,STATUSF_IP6
 		bnez	t1,ll_via_irq
 		 andi	t1,t0,STATUSF_IP5
diff -urN -X dontdiff linux/arch/parisc/kernel/entry.S rb/arch/parisc/kernel/entry.S
--- linux/arch/parisc/kernel/entry.S	Wed Dec  6 14:46:39 2000
+++ rb/arch/parisc/kernel/entry.S	Sun Jan  7 13:33:55 2001
@@ -1692,7 +1692,7 @@
 	ldw     IRQSTAT_SI_MASK(%r19),%r19	/* hardirq.h: unsigned int */
 	and     %r19,%r20,%r20
 	comib,<>,n 0,%r20,syscall_do_softirq /* forward */
-/* #endif */
+/* #endif	/* */ */
 
 
 syscall_check_resched:
diff -urN -X dontdiff linux/arch/ppc/kernel/pmac_setup.c rb/arch/ppc/kernel/pmac_setup.c
--- linux/arch/ppc/kernel/pmac_setup.c	Sun Sep 17 11:48:07 2000
+++ rb/arch/ppc/kernel/pmac_setup.c	Sun Jan  7 13:33:45 2001
@@ -727,5 +727,5 @@
 	prom_drawstring(s);
 	prom_drawchar('\n');
 }
-#endif CONFIG_BOOTX_TEXT
+#endif	/* CONFIG_BOOTX_TEXT */
 
diff -urN -X dontdiff linux/arch/sparc/kernel/ioport.c rb/arch/sparc/kernel/ioport.c
--- linux/arch/sparc/kernel/ioport.c	Mon Dec 11 15:37:02 2000
+++ rb/arch/sparc/kernel/ioport.c	Sun Jan  7 13:33:42 2001
@@ -703,7 +703,7 @@
 		}
 	}
 }
-#endif CONFIG_PCI
+#endif	/* CONFIG_PCI */
 
 #ifdef CONFIG_PROC_FS
 
@@ -725,7 +725,7 @@
 	return p-buf;
 }
 
-#endif CONFIG_PROC_FS
+#endif	/* CONFIG_PROC_FS */
 
 /*
  * This is a version of find_resource and it belongs to kernel/resource.c.
diff -urN -X dontdiff linux/drivers/atm/nicstar.c rb/drivers/atm/nicstar.c
--- linux/drivers/atm/nicstar.c	Fri Dec 29 17:35:47 2000
+++ rb/drivers/atm/nicstar.c	Sun Jan  7 13:33:34 2001
@@ -793,7 +793,7 @@
    u32d[0] = NS_RCTE_RAWCELLINTEN;
 #else
    u32d[0] = 0x00000000;
-#endif RCQ_SUPPORT
+#endif	/* RCQ_SUPPORT */
    u32d[1] = 0x00000000;
    u32d[2] = 0x00000000;
    u32d[3] = 0xFFFFFFFF;
diff -urN -X dontdiff linux/drivers/cdrom/sbpcd.c rb/drivers/cdrom/sbpcd.c
--- linux/drivers/cdrom/sbpcd.c	Fri Oct 27 01:35:48 2000
+++ rb/drivers/cdrom/sbpcd.c	Sun Jan  7 13:33:22 2001
@@ -338,7 +338,7 @@
 
 #ifndef SBPCD_ISSUE
 #define SBPCD_ISSUE 1
-#endif SBPCD_ISSUE
+#endif	/* SBPCD_ISSUE */
 
 #include <linux/module.h>
 
@@ -408,7 +408,7 @@
 #else
 #define SBPCD_CLI
 #define SBPCD_STI
-#endif SBPCD_DIS_IRQ
+#endif	/* SBPCD_DIS_IRQ */
 /*==========================================================================*/
 /*
  * auto-probing address list
@@ -466,9 +466,9 @@
 	0x370, 0, /* Lasermate, CI-101P */
 	0x290, 1, /* Soundblaster 16 */
 	0x310, 0, /* Lasermate, CI-101P, WDH-7001C */
-#endif MODULE
+#endif	/* MODULE */
 #endif
-#endif DISTRIBUTION
+#endif	/* DISTRIBUTION */
 };
 #else
 static int sbpcd[] = {CDROM_PORT, SBPRO}; /* probe with user's setup only */
@@ -557,7 +557,7 @@
 			  (1<<DBG_TOC) |
 			  (1<<DBG_MUL) |
 			  (1<<DBG_UPC));
-#endif DISTRIBUTION
+#endif	/* DISTRIBUTION */
 
 static int sbpcd_ioaddr = CDROM_PORT;	/* default I/O base address */
 static int sbpro_type = SBPRO;
@@ -606,7 +606,7 @@
 
 #if FUTURE
 static DECLARE_WAIT_QUEUE_HEAD(sbp_waitq);
-#endif FUTURE
+#endif	/* FUTURE */
 
 static int teac=SBP_TEAC_SPEED;
 static int buffers=SBP_BUFFER_FRAMES;
@@ -631,7 +631,7 @@
 #if OLD_BUSY
 static volatile u_char busy_data;
 static volatile u_char busy_audio; /* true semaphores would be safer */
-#endif OLD_BUSY
+#endif	/* OLD_BUSY */
 static DECLARE_MUTEX(ioctl_read_sem);
 static u_long timeout;
 static volatile u_char timed_out_delay;
@@ -648,7 +648,7 @@
 static u_int maxtim_data= 9000;
 #else
 static u_int maxtim_data= 3000;
-#endif LONG_TIMING
+#endif	/* LONG_TIMING */
 #if DISTRIBUTION
 static int n_retries=6;
 #else
@@ -713,7 +713,7 @@
 	u_char vol_ctrl2;
 	char vol_chan3;
 	u_char vol_ctrl3;
-#endif 000
+#endif	/* 000 */
 	u_char volume_control; /* TEAC on/off bits */
 	
 	u_char SubQ_ctl_adr;
@@ -742,7 +742,7 @@
 	u_int TocEnt_address;
 #if SAFE_MIXED
 	char has_data;
-#endif SAFE_MIXED
+#endif	/* SAFE_MIXED */
 	u_char ored_ctl_adr; /* to detect if CDROM contains data tracks */
 	
 	struct {
@@ -792,7 +792,7 @@
 #define MSG_LEVEL KERN_NOTICE
 #else
 #define MSG_LEVEL KERN_INFO
-#endif DISTRIBUTION
+#endif	/* DISTRIBUTION */
 
 	char buf[256];
 	va_list args;
@@ -808,7 +808,7 @@
 	printk(buf);
 #if KLOGD_PAUSE
 	sbp_sleep(KLOGD_PAUSE); /* else messages get lost */
-#endif KLOGD_PAUSE
+#endif	/* KLOGD_PAUSE */
 	return;
 }
 /*==========================================================================*/
@@ -1102,7 +1102,7 @@
 	return (0);
 }
 /*==========================================================================*/
-#endif 00000
+#endif	/* 00000 */
 /*==========================================================================*/
 static int ResponseInfo(void)
 {
@@ -1132,7 +1132,7 @@
 	}
 	j=i-response_count;
 	if (j>0) msg(DBG_INF,"ResponseInfo: got %d trailing bytes.\n",j);
-#endif 000
+#endif	/* 000 */
 	for (j=0;j<i;j++)
 		sprintf(&msgbuf[j*3]," %02X",infobuf[j]);
 	msgbuf[j*3]=0;
@@ -1384,7 +1384,7 @@
 		if (drvcmd[0]==CMDT_READ_VER) sbp_sleep(HZ); /* fixme */
 #if 01
 		OUT(CDo_sel_i_d,1);
-#endif 01
+#endif	/* 01 */
 		if (teac==2)
                   {
                     if ((i=CDi_stat_loop_T()) == -1) break;
@@ -1393,7 +1393,7 @@
                   {
 #if 0
                     OUT(CDo_sel_i_d,1);
-#endif 0
+#endif	/* 0 */
                     i=inb(CDi_status);
                   }
 		if (!(i&s_not_data_ready)) /* f.e. CMDT_DISKINFO */
@@ -1417,7 +1417,7 @@
                                                         l=1;
                                                         msg(DBG_TEA,"cmd_out_T: do_16bit: false first byte!\n");
                                                 }
-#endif TEST_FALSE_FF
+#endif	/* TEST_FALSE_FF */
                                         }
                                         else infobuf[l++]=inb(CDi_data);
                                         i=inb(CDi_status);
@@ -2012,7 +2012,7 @@
 		msg(DBG_TEA, "================CMDT_RESET given=================.\n");
 		sbp_sleep(3*HZ);
 	}
-#endif 1
+#endif	/* 1 */
 	flush_status();
 	i=GetStatus();
 	if (i<0) return i;
@@ -2333,7 +2333,7 @@
 		i=ResponseStatus();
 #if 0
                 sbp_sleep(HZ);
-#endif 0
+#endif	/* 0 */
 		i=ResponseStatus();
 	}
 	if (i<0)
@@ -2678,7 +2678,7 @@
 	D_S[d].vol_ctrl2=0xFF;
 	D_S[d].vol_chan3=3;
 	D_S[d].vol_ctrl3=0xFF;
-#endif 000
+#endif	/* 000 */
 	D_S[d].diskstate_flags |= volume_bit;
 	return (0);
 }
@@ -2978,20 +2978,20 @@
 	int i;
 #if TEST_UPC
 	int block, checksum;
-#endif TEST_UPC
+#endif	/* TEST_UPC */
 	
 	if (fam2_drive) return (0); /* not implemented yet */
 	if (famT_drive)	return (0); /* not implemented yet */
 	if (famV_drive)	return (0); /* not implemented yet */
 #if 1
 	if (fam0_drive) return (0); /* but it should work */
-#endif 1
+#endif	/* 1 */
 	
 	D_S[d].diskstate_flags &= ~upc_bit;
 #if TEST_UPC
 	for (block=CD_MSF_OFFSET+1;block<CD_MSF_OFFSET+200;block++)
 	{
-#endif TEST_UPC
+#endif	/* TEST_UPC */
 		clr_cmdbuf();
 		if (fam1_drive)
 		{
@@ -3000,7 +3000,7 @@
 			drvcmd[1]=(block>>16)&0xFF;
 			drvcmd[2]=(block>>8)&0xFF;
 			drvcmd[3]=block&0xFF;
-#endif TEST_UPC
+#endif	/* TEST_UPC */
 			response_count=8;
 			flags_cmd_out=f_putcmd|f_ResponseStatus|f_obey_p_check;
 		}
@@ -3011,7 +3011,7 @@
 			drvcmd[2]=(block>>16)&0xFF;
 			drvcmd[3]=(block>>8)&0xFF;
 			drvcmd[4]=block&0xFF;
-#endif TEST_UPC
+#endif	/* TEST_UPC */
 			response_count=0;
 			flags_cmd_out=f_putcmd|f_lopsta|f_getsta|f_ResponseStatus|f_obey_p_check|f_bit1;
 		}
@@ -3042,12 +3042,12 @@
 		}
 #if TEST_UPC
 		checksum=0;
-#endif TEST_UPC
+#endif	/* TEST_UPC */
 		for (i=0;i<(fam1_drive?8:16);i++)
 		{
 #if TEST_UPC
 			checksum |= infobuf[i];
-#endif TEST_UPC
+#endif	/* TEST_UPC */
 			sprintf(&msgbuf[i*3], " %02X", infobuf[i]);
 		}
 		msgbuf[i*3]=0;
@@ -3055,7 +3055,7 @@
 #if TEST_UPC
 		if ((checksum&0x7F)!=0) break;
 	}
-#endif TEST_UPC
+#endif	/* TEST_UPC */
 	D_S[d].UPC_ctl_adr=0;
 	if (fam1_drive) i=0;
 	else i=2;
@@ -3240,7 +3240,7 @@
 	i=cmd_out(); /* which buffer to use? */
 	return (i);
 }
-#endif FUTURE
+#endif	/* FUTURE */
 /*==========================================================================*/
 static void __init check_datarate(void)
 {
@@ -3267,7 +3267,7 @@
 		datarate++;
 #if 1
 		if (datarate>0x6FFFFFFF) break;
-#endif 00000
+#endif	/* 00000 */
 	}
 	while (!timed_out_delay);
 	del_timer(&delay_timer);
@@ -3283,7 +3283,7 @@
 	maxtim_data=datarate/100;
 #else
 	maxtim_data=datarate/300;
-#endif LONG_TIMING
+#endif	/* LONG_TIMING */
 #if 0
 	msg(DBG_TIM,"maxtim_8 %d, maxtim_data %d.\n", maxtim_8, maxtim_data);
 #endif
@@ -3437,7 +3437,7 @@
 		OUT(CDo_reset,0);
 		sbp_sleep(6*HZ);
 		OUT(CDo_enable,D_S[d].drv_sel);
-#endif 0
+#endif	/* 0 */
 		drvcmd[0]=CMD2_READ_VER;
 		response_count=12;
 		flags_cmd_out=f_putcmd;
@@ -3727,7 +3727,7 @@
 	OUT(port+3,save_port3);
 	return (0); /* in any case - no real "function" at time */
 }
-#endif PATH_CHECK
+#endif	/* PATH_CHECK */
 /*==========================================================================*/
 /*==========================================================================*/
 /*
@@ -3834,7 +3834,7 @@
 	if (func2==tell_UPC) return (-1);
 #else
 	return (0);
-#endif 000
+#endif	/* 000 */
 }
 /*==========================================================================*/
 static int check_allowed2(u_char func1, u_char func2)
@@ -3852,7 +3852,7 @@
 	}
 #else
 	return (0);
-#endif 000
+#endif	/* 000 */
 }
 /*==========================================================================*/
 static int check_allowed3(u_char func1, u_char func2)
@@ -3886,7 +3886,7 @@
 	if (func1==audio_resume) return (-1);
 #else
 	return (0);
-#endif 000
+#endif	/* 000 */
 }
 /*==========================================================================*/
 static int seek_pos_audio_end(void)
@@ -3898,7 +3898,7 @@
 	i=cc_Seek(i,0);
 	return (i);
 }
-#endif FUTURE
+#endif	/* FUTURE */
 /*==========================================================================*/
 static int ReadToC(void)
 {
@@ -4136,7 +4136,7 @@
     }
 	return (0);
 }
-#endif FUTURE
+#endif	/* FUTURE */
 /*==========================================================================*/
 /*==========================================================================*/
 /*
@@ -4234,7 +4234,7 @@
 		msg(DBG_IOC,"ioctl: CDROMREADMODE1 requested.\n");
 #if SAFE_MIXED
 		if (D_S[d].has_data>1) RETURN_UP(-EBUSY);
-#endif SAFE_MIXED
+#endif	/* SAFE_MIXED */
 		cc_ModeSelect(CD_FRAMESIZE);
 		cc_ModeSense();
 		D_S[d].mode=READ_M1;
@@ -4244,7 +4244,7 @@
 		msg(DBG_IOC,"ioctl: CDROMREADMODE2 requested.\n");
 #if SAFE_MIXED
 		if (D_S[d].has_data>1) RETURN_UP(-EBUSY);
-#endif SAFE_MIXED
+#endif	/* SAFE_MIXED */
 		cc_ModeSelect(CD_FRAMESIZE_RAW1);
 		cc_ModeSense();
 		D_S[d].mode=READ_M2;
@@ -4287,7 +4287,7 @@
 		if (famT_drive) RETURN_UP(-EINVAL);
 #if SAFE_MIXED
 		if (D_S[d].has_data>1) RETURN_UP(-EBUSY);
-#endif SAFE_MIXED
+#endif	/* SAFE_MIXED */
 		if (D_S[d].aud_buf==NULL) RETURN_UP(-EINVAL);
 		i=verify_area(VERIFY_READ, (void *) arg, sizeof(struct cdrom_read_audio));
 		if (i) RETURN_UP(i);
@@ -4312,7 +4312,7 @@
 #if OLD_BUSY
 		while (busy_data) sbp_sleep(HZ/10); /* wait a bit */
 		busy_audio=1;
-#endif OLD_BUSY
+#endif	/* OLD_BUSY */
 		error_flag=0;
 		for (data_tries=5; data_tries>0; data_tries--)
 		{
@@ -4444,7 +4444,7 @@
 				i=cc_DriveReset();                /* ugly fix to prevent a hang */
 #else
 				i=cc_ReadError();
-#endif 0000
+#endif	/* 0000 */
 				continue;
 			}
 			if (fam0L_drive)
@@ -4499,7 +4499,7 @@
 		D_S[d].mode=READ_M1;
 #if OLD_BUSY
 		busy_audio=0;
-#endif OLD_BUSY
+#endif	/* OLD_BUSY */
 		if (data_tries == 0)
 		{
 			msg(DBG_AUD,"read_audio: failed after 5 tries in line %d.\n", __LINE__);
@@ -4585,7 +4585,7 @@
 		msg(DBG_IOC,"ioctl: CDROMPLAYMSF entered.\n");
 #if SAFE_MIXED
 		if (D_S[d].has_data>1) RETURN_UP(-EBUSY);
-#endif SAFE_MIXED
+#endif	/* SAFE_MIXED */
 		if (D_S[d].audio_state==audio_playing)
 		{
 			i=cc_Pause_Resume(1);
@@ -4620,7 +4620,7 @@
 		msg(DBG_IOC,"ioctl: CDROMPLAYTRKIND entered.\n");
 #if SAFE_MIXED
 		if (D_S[d].has_data>1) RETURN_UP(-EBUSY);
-#endif SAFE_MIXED
+#endif	/* SAFE_MIXED */
 		if (D_S[d].audio_state==audio_playing)
 		{
 			msg(DBG_IOX,"CDROMPLAYTRKIND: already audio_playing.\n");
@@ -4683,7 +4683,7 @@
 		msg(DBG_IOC,"ioctl: CDROMSTOP entered.\n");
 #if SAFE_MIXED
 		if (D_S[d].has_data>1) RETURN_UP(-EBUSY);
-#endif SAFE_MIXED
+#endif	/* SAFE_MIXED */
 		i=cc_Pause_Resume(1);
 		D_S[d].audio_state=0;
 #if 0
@@ -4926,7 +4926,7 @@
 #if OLD_BUSY
 	while (busy_audio) sbp_sleep(HZ); /* wait a bit */
 	busy_data=1;
-#endif OLD_BUSY
+#endif	/* OLD_BUSY */
 	
 	if (D_S[i].audio_state==audio_playing) goto err_done;
 	if (d!=i) switch_drive(i);
@@ -4957,7 +4957,7 @@
 	i=prepare(0,0); /* at moment not really a hassle check, but ... */
 	if (i!=0)
 		msg(DBG_INF,"\"prepare\" tells error %d -- ignored\n", i);
-#endif FUTURE
+#endif	/* FUTURE */
 	
 	if (!st_spinning) cc_SpinUp();
 	
@@ -4983,7 +4983,7 @@
 		{
 #if SAFE_MIXED
 			D_S[d].has_data=2; /* is really a data disk */
-#endif SAFE_MIXED
+#endif	/* SAFE_MIXED */
 #ifdef DEBUG_GTL
 			printk(" do_sbpcd_request[%do](%p:%ld+%ld) end 3, Time:%li\n",
 				xnr, req, req->sector, req->nr_sectors, jiffies);
@@ -4998,7 +4998,7 @@
  err_done:
 #if OLD_BUSY
 	busy_data=0;
-#endif OLD_BUSY
+#endif	/* OLD_BUSY */
 #ifdef DEBUG_GTL
 	printk(" do_sbpcd_request[%do](%p:%ld+%ld) end 4 (error), Time:%li\n",
 		xnr, req, req->sector, req->nr_sectors, jiffies);
@@ -5357,17 +5357,17 @@
 	
 #if 0
 	if (!success)
-#endif 0
+#endif	/* 0 */
 		do
 		{
 			if (fam0LV_drive) cc_ReadStatus();
 #if 1
 			if (famT_drive) msg(DBG_TEA, "================before ResponseStatus=================.\n", i);
-#endif 1
+#endif	/* 1 */
 			i=ResponseStatus();  /* builds status_bits, returns orig. status (old) or faked p_success (new) */
 #if 1
 			if (famT_drive)	msg(DBG_TEA, "================ResponseStatus: %d=================.\n", i);
-#endif 1
+#endif	/* 1 */
 			if (i<0)
 			{
 				msg(DBG_INF,"bad cc_ReadStatus after read: %02X\n", D_S[d].status_bits);
@@ -5427,11 +5427,11 @@
 			msg(DBG_INF,"CD contains no data tracks.\n");
 #if SAFE_MIXED
 			D_S[d].has_data=0;
-#endif SAFE_MIXED
+#endif	/* SAFE_MIXED */
 		}
 #if SAFE_MIXED
 		else if (D_S[d].has_data<1) D_S[d].has_data=1;
-#endif SAFE_MIXED
+#endif	/* SAFE_MIXED */
 	}
 	if (!st_spinning) cc_SpinUp();
 	RETURN_UP(0);
@@ -5469,7 +5469,7 @@
 			D_S[d].open_count=0; 
 #if SAFE_MIXED
 			D_S[d].has_data=0;
-#endif SAFE_MIXED
+#endif	/* SAFE_MIXED */
 		}
 	}
 	up(&ioctl_read_sem);
@@ -5660,7 +5660,7 @@
 int __init __SBPCD_INIT(void)
 #else
 int __init SBPCD_INIT(void)
-#endif MODULE
+#endif	/* MODULE */
 {
 	char nbuff[16];
 	int i=0, j=0;
@@ -5687,10 +5687,10 @@
 		msg(DBG_INF,"with your REAL address.\n");
 		msg(DBG_INF,"= = = = = = = = = = END of WARNING = = = = = == = = =\n");
 	}
-#endif DISTRIBUTION
+#endif	/* DISTRIBUTION */
 	sbpcd[0]=sbpcd_ioaddr; /* possibly changed by kernel command line */
 	sbpcd[1]=sbpro_type; /* possibly changed by kernel command line */
-#endif MODULE
+#endif	/* MODULE */
 	
 	for (port_index=0;port_index<NUM_PROBE;port_index+=2)
 	{
@@ -5708,7 +5708,7 @@
 		sbpcd_setup((char *)type);
 #if DISTRIBUTION
 		msg(DBG_INF,"Scanning 0x%X (%s)...\n", CDo_command, type);
-#endif DISTRIBUTION
+#endif	/* DISTRIBUTION */
 		if (sbpcd[port_index+1]==2)
 		{
 			i=config_spea();
@@ -5716,7 +5716,7 @@
 		}
 #ifdef PATH_CHECK
 		if (check_card(addr[1])) continue;
-#endif PATH_CHECK
+#endif	/* PATH_CHECK */
 		i=check_drives();
 		msg(DBG_INI,"check_drives done.\n");
 		if (i>=0) break; /* drive found */
@@ -5729,7 +5729,7 @@
 		return -EIO;
 #else
 		goto init_done;
-#endif MODULE
+#endif	/* MODULE */
 	}
 	
 	if (port_index>0)
@@ -5746,7 +5746,7 @@
 		switch_drive(j);
 #if 1
 		if (!famL_drive) cc_DriveReset();
-#endif 0
+#endif	/* 0 */
 		if (!st_spinning) cc_SpinUp();
 		D_S[j].sbp_first_frame = -1;  /* First frame in buffer */
 		D_S[j].sbp_last_frame = -1;   /* Last frame in buffer  */
@@ -5757,7 +5757,7 @@
 		D_S[j].f_eject=0;
 #if EJECT
 		if (!fam0_drive) D_S[j].f_eject=1;
-#endif EJECT
+#endif	/* EJECT */
 		cc_ReadStatus();
 		i=ResponseStatus();  /* returns orig. status or p_busy_new */
 		if (famT_drive) i=ResponseStatus();  /* returns orig. status or p_busy_new */
@@ -5803,7 +5803,7 @@
 #if SOUND_BASE
 	OUT(MIXER_addr,MIXER_CD_Volume); /* select SB Pro mixer register */
 	OUT(MIXER_data,0xCC); /* one nibble per channel, max. value: 0xFF */
-#endif SOUND_BASE
+#endif	/* SOUND_BASE */
 	
 	if (devfs_register_blkdev(MAJOR_NR, major_name, &cdrom_fops) != 0)
 	{
@@ -5812,7 +5812,7 @@
 		return -EIO;
 #else
 		goto init_done;
-#endif MODULE
+#endif	/* MODULE */
 	}
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
 	blk_queue_headactive(BLK_DEFAULT_QUEUE(MAJOR_NR), 0);
@@ -5829,7 +5829,7 @@
 		switch_drive(j);
 #if SAFE_MIXED
 		D_S[j].has_data=0;
-#endif SAFE_MIXED
+#endif	/* SAFE_MIXED */
 		/*
 		 * allocate memory for the frame buffers
 		 */
@@ -5852,7 +5852,7 @@
 		}
 #ifdef MODULE
 		msg(DBG_INF,"data buffer size: %d frames.\n",buffers);
-#endif MODULE
+#endif	/* MODULE */
 		if (D_S[j].sbp_audsiz>0)
 		{
 			D_S[j].aud_buf=(u_char *) vmalloc(D_S[j].sbp_audsiz*CD_FRAMESIZE_RAW);
@@ -5892,15 +5892,15 @@
 #if !(SBPCD_ISSUE-1)
 #ifdef CONFIG_SBPCD2
 	sbpcd2_init();
-#endif CONFIG_SBPCD2
+#endif	/* CONFIG_SBPCD2 */
 #ifdef CONFIG_SBPCD3
 	sbpcd3_init();
-#endif CONFIG_SBPCD3
+#endif	/* CONFIG_SBPCD3 */
 #ifdef CONFIG_SBPCD4
 	sbpcd4_init();
-#endif CONFIG_SBPCD4
-#endif !(SBPCD_ISSUE-1)
-#endif MODULE
+#endif	/* CONFIG_SBPCD4 */
+#endif	/* !(SBPCD_ISSUE-1) */
+#endif	/* MODULE */
 	return 0;
 }
 /*==========================================================================*/
@@ -5939,7 +5939,7 @@
 module_exit(sbpcd_exit);
 
 
-#endif MODULE
+#endif	/* MODULE */
 /*==========================================================================*/
 /*
  * Check if the media has changed in the CD-ROM drive.
@@ -5962,7 +5962,7 @@
 		D_S[d].diskstate_flags &= ~cd_size_bit;
 #if SAFE_MIXED
 		D_S[d].has_data=0;
-#endif SAFE_MIXED
+#endif	/* SAFE_MIXED */
 
                 return (1);
         }
diff -urN -X dontdiff linux/drivers/char/pcxx.c rb/drivers/char/pcxx.c
--- linux/drivers/char/pcxx.c	Mon Jan  1 13:34:54 2001
+++ rb/drivers/char/pcxx.c	Sun Jan  7 13:32:57 2001
@@ -122,7 +122,7 @@
 MODULE_PARM(numports,    "1-4i");
 # endif
 
-#endif MODULE
+#endif	/* MODULE */
 
 static int numcards = 1;
 static int nbdevs = 0;
diff -urN -X dontdiff linux/drivers/i2c/i2c-pcf8584.h rb/drivers/i2c/i2c-pcf8584.h
--- linux/drivers/i2c/i2c-pcf8584.h	Fri Jan 28 22:36:23 2000
+++ rb/drivers/i2c/i2c-pcf8584.h	Sun Jan  7 13:33:35 2001
@@ -75,4 +75,4 @@
 #define I2C_PCF_INTREG	I2C_PCF_ES2
 #define I2C_PCF_CLKREG	I2C_PCF_ES1
 
-#endif I2C_PCF8584_H
+#endif	/* I2C_PCF8584_H */
diff -urN -X dontdiff linux/drivers/ide/pdc4030.h rb/drivers/ide/pdc4030.h
--- linux/drivers/ide/pdc4030.h	Sat Feb 26 23:32:14 2000
+++ rb/drivers/ide/pdc4030.h	Sun Jan  7 13:33:28 2001
@@ -41,4 +41,4 @@
 	u8	pad[SECTOR_WORDS*4 - 32];
 };
 
-#endif IDE_PROMISE_H
+#endif	/* IDE_PROMISE_H */
diff -urN -X dontdiff linux/drivers/ide/rz1000.c rb/drivers/ide/rz1000.c
--- linux/drivers/ide/rz1000.c	Fri Apr 14 00:54:26 2000
+++ rb/drivers/ide/rz1000.c	Sun Jan  7 13:33:28 2001
@@ -94,4 +94,4 @@
 		init_rz1000 (dev, "RZ1001");
 }
 
-#endif CONFIG_BLK_DEV_IDEPCI
+#endif	/* CONFIG_BLK_DEV_IDEPCI */
diff -urN -X dontdiff linux/drivers/net/3c527.h rb/drivers/net/3c527.h
--- linux/drivers/net/3c527.h	Sun Mar 21 10:11:36 1999
+++ rb/drivers/net/3c527.h	Sun Jan  7 13:32:49 2001
@@ -37,4 +37,4 @@
 #define CONTROL_EL	0x40	/* End of List */
 
 
-#define MCA_MC32_ID	0x0041	/* Our MCA ident */
\ No newline at end of file
+#define MCA_MC32_ID	0x0041	/* Our MCA ident */
diff -urN -X dontdiff linux/drivers/net/myri_code.h rb/drivers/net/myri_code.h
--- linux/drivers/net/myri_code.h	Wed Apr 23 21:01:20 1997
+++ rb/drivers/net/myri_code.h	Sun Jan  7 13:32:39 2001
@@ -6284,4 +6284,4 @@
 #define MYRI_NetReceiveBadCrcs       0xB8D4
 #define MYRI_NetReceiveBytes         0xB8DC
 
-#endif SYMBOL_DEFINES_COMPILED
+#endif	/* SYMBOL_DEFINES_COMPILED */
diff -urN -X dontdiff linux/drivers/net/pcmcia/i82593.h rb/drivers/net/pcmcia/i82593.h
--- linux/drivers/net/pcmcia/i82593.h	Wed Oct 20 23:33:12 1999
+++ rb/drivers/net/pcmcia/i82593.h	Sun Jan  7 13:32:50 2001
@@ -221,4 +221,4 @@
 
 #define I82593_MAX_MULTICAST_ADDRESSES	128	/* Hardware hashed filter */
 
-#endif _I82593_H
+#endif	/* _I82593_H */
diff -urN -X dontdiff linux/drivers/net/pcmcia/wavelan_cs.c rb/drivers/net/pcmcia/wavelan_cs.c
--- linux/drivers/net/pcmcia/wavelan_cs.c	Thu Jan  4 15:50:12 2001
+++ rb/drivers/net/pcmcia/wavelan_cs.c	Sun Jan  7 13:32:51 2001
@@ -22,7 +22,7 @@
 #ifdef WAVELAN_ROAMING	
  * Roaming support added 07/22/98 by Justin Seger (jseger@media.mit.edu)
  * based on patch by Joe Finney from Lancaster University.
-#endif :-)
+#endif	/* :-) */
  *
  * Lucent (formerly AT&T GIS, formerly NCR) WaveLAN PCMCIA card: An
  * Ethernet-like radio transceiver controlled by an Intel 82593 coprocessor.
@@ -1774,7 +1774,7 @@
 #if WIRELESS_EXT > 7
   const int	BAND_NUM = 10;	/* Number of bands */
   int		c = 0;		/* Channel number */
-#endif WIRELESS_EXT
+#endif	/* WIRELESS_EXT */
 
   /* Read the frequency table */
   fee_read(base, 0x71 /* frequency table */,
@@ -1792,7 +1792,7 @@
 	      (c < BAND_NUM))
 	  c++;
 	list[i].i = c;	/* Set the list index */
-#endif WIRELESS_EXT
+#endif	/* WIRELESS_EXT */
 
 	/* put in the list */
 	list[i].m = (((freq + 24) * 5) + 24000L) * 10000;
diff -urN -X dontdiff linux/drivers/net/wan/lmc/lmc_media.h rb/drivers/net/wan/lmc/lmc_media.h
--- linux/drivers/net/wan/lmc/lmc_media.h	Fri Apr 21 18:08:45 2000
+++ rb/drivers/net/wan/lmc/lmc_media.h	Sun Jan  7 13:32:37 2001
@@ -61,4 +61,4 @@
 };
 
 
-#endif
\ No newline at end of file
+#endif
diff -urN -X dontdiff linux/drivers/net/wan/lmc/lmc_prot.h rb/drivers/net/wan/lmc/lmc_prot.h
--- linux/drivers/net/wan/lmc/lmc_prot.h	Fri Apr 21 18:08:45 2000
+++ rb/drivers/net/wan/lmc/lmc_prot.h	Sun Jan  7 13:32:37 2001
@@ -11,4 +11,4 @@
 unsigned short lmc_proto_type(lmc_softc_t *sc const, struct skbuff *skb)
 
 
-#endif
\ No newline at end of file
+#endif
diff -urN -X dontdiff linux/drivers/sbus/char/aurora.c rb/drivers/sbus/char/aurora.c
--- linux/drivers/sbus/char/aurora.c	Mon Dec 11 15:37:03 2000
+++ rb/drivers/sbus/char/aurora.c	Sun Jan  7 13:33:27 2001
@@ -701,7 +701,7 @@
 		}
 		sbus_writeb(port->SRER, &bp->r[chip]->r[CD180_SRER]);
 	}
-#endif AURORA_BRAIN_DAMAGED_CTS */
+#endif	/* AURORA_BRAIN_DAMAGED_CTS */ */
 	
 	/* Clear change bits */
 	sbus_writeb(0, &bp->r[chip]->r[CD180_MCR]);
diff -urN -X dontdiff linux/drivers/scsi/NCR53c406a.c rb/drivers/scsi/NCR53c406a.c
--- linux/drivers/scsi/NCR53c406a.c	Mon Sep 18 15:36:24 2000
+++ rb/drivers/scsi/NCR53c406a.c	Sun Jan  7 13:33:12 2001
@@ -221,7 +221,7 @@
     (void *)0xc8000
 };
 #define ADDRESS_COUNT (sizeof( addresses ) / sizeof( unsigned ))
-#endif USE_BIOS
+#endif	/* USE_BIOS */
 		       
 /* possible i/o port addresses */
 static unsigned short ports[] =
@@ -244,7 +244,7 @@
     { "Copyright (C) Acculogic, Inc.\r\n2.8M Diskette Extension Bios ver 4.04.03 03/01/1993", 61, 82 },
 };
 #define SIGNATURE_COUNT (sizeof( signatures ) / sizeof( struct signature ))
-#endif USE_BIOS
+#endif	/* USE_BIOS */
 
 /* ============================================================ */
 
@@ -347,7 +347,7 @@
     
     return tmp;
 }
-#endif USE_DMA
+#endif	/* USE_DMA */
 
 #if USE_PIO
 static __inline__ int NCR53c406a_pio_read(unsigned char *request, 
@@ -455,7 +455,7 @@
     }
     return 0;
 }
-#endif USE_PIO
+#endif	/* USE_PIO */
 
 int  __init 
 NCR53c406a_detect(Scsi_Host_Template * tpnt){
@@ -481,7 +481,7 @@
     }
     
     DEB(printk("NCR53c406a BIOS found at %X\n", (unsigned int) bios_base););
-#endif USE_BIOS
+#endif	/* USE_BIOS */
     
 #ifdef PORT_BASE
     if (check_region(port_base, 0x10)) /* ports already snatched */
@@ -510,7 +510,7 @@
             }
         }
     }
-#endif PORT_BASE
+#endif	/* PORT_BASE */
     
     if(!port_base){		/* no ports found */
         printk("NCR53c406a: no available ports found\n");
@@ -549,7 +549,7 @@
 #if USE_DMA
         printk("NCR53c406a: No interrupts found and DMA mode defined. Giving up.\n");
         return 0;
-#endif USE_DMA
+#endif	/* USE_DMA */
     }
     else {
         DEB(printk("NCR53c406a: Shouldn't get here!\n"));
@@ -564,7 +564,7 @@
     }
     
     DEB(printk("Allocated DMA channel %d\n", dma_chan));
-#endif USE_DMA 
+#endif	/* USE_DMA  */
     
     tpnt->present = 1;
     tpnt->proc_name = "NCR53c406a";
@@ -804,8 +804,8 @@
     printk("\n");
 #else
     printk(", pio=%02x\n", pio_status);
-#endif USE_DMA
-#endif NCR53C406A_DEBUG
+#endif	/* USE_DMA */
+#endif	/* NCR53C406A_DEBUG */
     
     if(int_reg & 0x80){         /* SCSI reset intr */
         rtrc(3);
@@ -824,7 +824,7 @@
         current_SC->scsi_done(current_SC);
         return;
     }
-#endif USE_PIO
+#endif	/* USE_PIO */
     
     if(status & 0x20) {		/* Parity error */
         printk("NCR53c406a: Warning: parity error!\n");
@@ -869,7 +869,7 @@
 #if USE_DMA			/* No s/g support for DMA */
             NCR53c406a_dma_write(current_SC->request_buffer, 
                                  current_SC->request_bufflen);
-#endif USE_DMA
+#endif	/* USE_DMA */
             outb(TRANSFER_INFO | DMA_OP, CMD_REG); 
 #if USE_PIO
             if (!current_SC->use_sg) /* Don't use scatter-gather */
@@ -884,7 +884,7 @@
                 }
             }
             REG0;
-#endif USE_PIO
+#endif	/* USE_PIO */
         }
         break;
         
@@ -898,7 +898,7 @@
 #if USE_DMA			/* No s/g support for DMA */
             NCR53c406a_dma_read(current_SC->request_buffer, 
                                 current_SC->request_bufflen);
-#endif USE_DMA
+#endif	/* USE_DMA */
             outb(TRANSFER_INFO | DMA_OP, CMD_REG); 
 #if USE_PIO
             if (!current_SC->use_sg) /* Don't use scatter-gather */
@@ -913,7 +913,7 @@
                 }
             }
             REG0;
-#endif USE_PIO
+#endif	/* USE_PIO */
         }
         break;
         
@@ -995,7 +995,7 @@
     
     return irq;
 }
-#endif IRQ_LEV
+#endif	/* IRQ_LEV */
 
 static void chip_init()
 {
diff -urN -X dontdiff linux/drivers/scsi/dec_esp.c rb/drivers/scsi/dec_esp.c
--- linux/drivers/scsi/dec_esp.c	Mon Jul 10 00:22:57 2000
+++ rb/drivers/scsi/dec_esp.c	Sun Jan  7 13:33:18 2001
@@ -524,4 +524,4 @@
 	    (char *) KSEG0ADDR((sp->request_buffer));
 }
 
-#endif
\ No newline at end of file
+#endif
diff -urN -X dontdiff linux/drivers/sound/wavfront.c rb/drivers/sound/wavfront.c
--- linux/drivers/sound/wavfront.c	Sun Dec 31 13:26:18 2000
+++ rb/drivers/sound/wavfront.c	Sun Jan  7 13:33:20 2001
@@ -131,7 +131,7 @@
 #if    OSS_SUPPORT_LEVEL & OSS_SUPPORT_SEQ
 static int (*midi_load_patch) (int devno, int format, const char *addr,
 			       int offs, int count, int pmgr_flag) = NULL;
-#endif OSS_SUPPORT_SEQ
+#endif	/* OSS_SUPPORT_SEQ */
 
 /* if WF_DEBUG not defined, no run-time debugging messages will
    be available via the debug flag setting. Given the current
@@ -279,7 +279,7 @@
         int fx_mididev;                    /* devno for FX MIDI interface */
 #if OSS_SUPPORT_LEVEL & OSS_SUPPORT_SEQ
 	int oss_dev;                      /* devno for OSS sequencer synth */
-#endif OSS_SUPPORT_SEQ
+#endif	/* OSS_SUPPORT_SEQ */
 
 	char fw_version[2];                /* major = [0], minor = [1] */
 	char hw_version[2];                /* major = [0], minor = [1] */
@@ -2139,7 +2139,7 @@
 	bender:		midi_synth_bender,
 	setup_voice:	midi_synth_setup_voice
 };
-#endif OSS_SUPPORT_SEQ
+#endif	/* OSS_SUPPORT_SEQ */
 
 #if OSS_SUPPORT_LEVEL & OSS_SUPPORT_STATIC_INSTALL
 
@@ -2158,7 +2158,7 @@
     (void) uninstall_wavefront ();
 }
 
-#endif OSS_SUPPORT_STATIC_INSTALL
+#endif	/* OSS_SUPPORT_STATIC_INSTALL */
 
 /***********************************************************************/
 /* WaveFront: Linux modular sound kernel installation interface        */
@@ -2674,7 +2674,7 @@
 		    &wavefront_oss_load_patch;
 	}
 
-#endif OSS_SUPPORT_SEQ
+#endif	/* OSS_SUPPORT_SEQ */
 	
 	/* Turn on Virtual MIDI, but first *always* turn it off,
 	   since otherwise consectutive reloads of the driver will
@@ -2852,14 +2852,14 @@
 	} else {
 		synth_devs[dev.oss_dev] = &wavefront_operations;
 	}
-#endif OSS_SUPPORT_SEQ
+#endif	/* OSS_SUPPORT_SEQ */
 
 	if (wavefront_init (1) < 0) {
 		printk (KERN_WARNING LOGNAME "initialization failed.\n");
 
 #if OSS_SUPPORT_LEVEL & OSS_SUPPORT_SEQ
 		sound_unload_synthdev (dev.oss_dev);
-#endif OSS_SUPPORT_SEQ
+#endif	/* OSS_SUPPORT_SEQ */
 
 		return -1;
 	}
@@ -2890,7 +2890,7 @@
 
 #if OSS_SUPPORT_LEVEL & OSS_SUPPORT_SEQ
 	sound_unload_synthdev (dev.oss_dev);
-#endif OSS_SUPPORT_SEQ
+#endif	/* OSS_SUPPORT_SEQ */
 	uninstall_wf_mpu ();
 }
 
diff -urN -X dontdiff linux/drivers/sound/yss225.h rb/drivers/sound/yss225.h
--- linux/drivers/sound/yss225.h	Sat Jul 18 16:11:41 1998
+++ rb/drivers/sound/yss225.h	Sun Jan  7 13:33:20 2001
@@ -20,5 +20,5 @@
 extern unsigned char coefficients3[404];
 
 
-#endif __ys225_h__
+#endif	/* __ys225_h__ */
 
diff -urN -X dontdiff linux/drivers/usb/net1080.c rb/drivers/usb/net1080.c
--- linux/drivers/usb/net1080.c	Thu Jan  4 16:15:32 2001
+++ rb/drivers/usb/net1080.c	Sun Jan  7 13:33:33 2001
@@ -589,7 +589,7 @@
 	}
 #ifdef	VERBOSE
 	dbg ("no read resubmitted");
-#endif	VERBOSE
+#endif	/* VERBOSE */
 }
 
 /*-------------------------------------------------------------------------*/
diff -urN -X dontdiff linux/drivers/usb/serial/keyspan.c rb/drivers/usb/serial/keyspan.c
--- linux/drivers/usb/serial/keyspan.c	Mon Dec 11 16:47:32 2000
+++ rb/drivers/usb/serial/keyspan.c	Sun Jan  7 13:33:33 2001
@@ -66,7 +66,7 @@
 #define DEBUG
 /*  #ifdef CONFIG_USB_SERIAL_DEBUG */
 	#define DEBUG
-/*  #endif */
+/*  #endif	/* */ */
 #include <linux/usb.h>
 
 #include "usb-serial.h"
diff -urN -X dontdiff linux/drivers/video/amifb.c rb/drivers/video/amifb.c
--- linux/drivers/video/amifb.c	Fri Dec 29 17:07:23 2000
+++ rb/drivers/video/amifb.c	Sun Jan  7 13:33:28 2001
@@ -1534,7 +1534,7 @@
 			}
 			return i;
 		}
-#endif */ DEBUG */
+#endif	/* */ DEBUG */ */
 	}
 	return -EINVAL;
 }
diff -urN -X dontdiff linux/include/asm-arm/arch-sa1100/SA-1101.h rb/include/asm-arm/arch-sa1100/SA-1101.h
--- linux/include/asm-arm/arch-sa1100/SA-1101.h	Wed Jul 19 00:43:25 2000
+++ rb/include/asm-arm/arch-sa1100/SA-1101.h	Sun Jan  7 13:31:54 2001
@@ -143,7 +143,7 @@
 #define VMCCR_SDTCTest	    Fld(7,24)	  /* stale data timeout counter */
 #define VMCCR_ForceSelfRef  (1<<31)	  /* Force self refresh */
 
-#endif LANGUAGE == C
+#endif	/* LANGUAGE == C */
 
 
 /* Update FIFO
diff -urN -X dontdiff linux/include/asm-i386/mca_dma.h rb/include/asm-i386/mca_dma.h
--- linux/include/asm-i386/mca_dma.h	Wed Apr 12 11:47:29 2000
+++ rb/include/asm-i386/mca_dma.h	Sun Jan  7 13:31:50 2001
@@ -199,4 +199,4 @@
 	outb(mode, MCA_DMA_REG_EXE);
 }
 
-#endif MCA_DMA_H
+#endif	/* MCA_DMA_H */
diff -urN -X dontdiff linux/include/asm-ia64/sn/hcl_util.h rb/include/asm-ia64/sn/hcl_util.h
--- linux/include/asm-ia64/sn/hcl_util.h	Thu Jan  4 16:00:15 2001
+++ rb/include/asm-ia64/sn/hcl_util.h	Sun Jan  7 13:31:59 2001
@@ -21,4 +21,4 @@
 extern void *device_info_get(devfs_handle_t);
 
 
-#endif _ASM_SN_HCL_UTIL_H
+#endif	/* _ASM_SN_HCL_UTIL_H */
diff -urN -X dontdiff linux/include/asm-ia64/sn/synergy.h rb/include/asm-ia64/sn/synergy.h
--- linux/include/asm-ia64/sn/synergy.h	Thu Jan  4 16:00:15 2001
+++ rb/include/asm-ia64/sn/synergy.h	Sun Jan  7 13:32:00 2001
@@ -124,4 +124,4 @@
 
 /* Temporary defintions for testing: */
 
-#endif ASM_IA64_SN_SYNERGY_H
+#endif	/* ASM_IA64_SN_SYNERGY_H */
diff -urN -X dontdiff linux/include/asm-m68k/pgtable.h rb/include/asm-m68k/pgtable.h
--- linux/include/asm-m68k/pgtable.h	Mon Nov 27 21:00:49 2000
+++ rb/include/asm-m68k/pgtable.h	Sun Jan  7 13:31:51 2001
@@ -160,7 +160,7 @@
 #define pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) })
 #define swp_entry_to_pte(x)		((pte_t) { (x).val })
 
-#endif CONFIG_SUN3
+#endif	/* CONFIG_SUN3 */
 
 #endif /* !__ASSEMBLY__ */
 
diff -urN -X dontdiff linux/include/asm-m68k/sun3-head.h rb/include/asm-m68k/sun3-head.h
--- linux/include/asm-m68k/sun3-head.h	Sat Sep  4 15:06:41 1999
+++ rb/include/asm-m68k/sun3-head.h	Sun Jan  7 13:31:51 2001
@@ -9,4 +9,4 @@
 #define FC_SUPERD    5
 #define FC_CPU      7
 
-#endif __SUN3_HEAD_H
+#endif	/* __SUN3_HEAD_H */
diff -urN -X dontdiff linux/include/asm-mips/watch.h rb/include/asm-mips/watch.h
--- linux/include/asm-mips/watch.h	Sat May 13 10:31:25 2000
+++ rb/include/asm-mips/watch.h	Sun Jan  7 13:31:50 2001
@@ -35,4 +35,4 @@
 	if (watch_available)					\
 		__watch_reenable()
 
-#endif __ASM_WATCH_H
+#endif	/* __ASM_WATCH_H */
diff -urN -X dontdiff linux/include/asm-mips64/smp.h rb/include/asm-mips64/smp.h
--- linux/include/asm-mips64/smp.h	Fri Aug  4 18:15:37 2000
+++ rb/include/asm-mips64/smp.h	Sun Jan  7 13:32:01 2001
@@ -45,4 +45,4 @@
 
 #define NO_PROC_ID	(-1)
 
-#endif __ASM_SMP_H
+#endif	/* __ASM_SMP_H */
diff -urN -X dontdiff linux/include/asm-mips64/sn/mapped_kernel.h rb/include/asm-mips64/sn/mapped_kernel.h
--- linux/include/asm-mips64/sn/mapped_kernel.h	Wed Nov 29 00:42:04 2000
+++ rb/include/asm-mips64/sn/mapped_kernel.h	Sun Jan  7 13:32:01 2001
@@ -52,4 +52,4 @@
 #define MAPPED_KERN_RO_TO_K0(x)	PHYS_TO_K0(MAPPED_KERN_RO_TO_PHYS(x))
 #define MAPPED_KERN_RW_TO_K0(x)	PHYS_TO_K0(MAPPED_KERN_RW_TO_PHYS(x))
 
-#endif __ASM_SN_MAPPED_KERNEL_H
+#endif	/* __ASM_SN_MAPPED_KERNEL_H */
diff -urN -X dontdiff linux/include/asm-mips64/watch.h rb/include/asm-mips64/watch.h
--- linux/include/asm-mips64/watch.h	Sat May 13 10:31:25 2000
+++ rb/include/asm-mips64/watch.h	Sun Jan  7 13:32:01 2001
@@ -35,4 +35,4 @@
 	if (watch_available)					\
 		__watch_reenable()
 
-#endif _ASM_WATCH_H
+#endif	/* _ASM_WATCH_H */
diff -urN -X dontdiff linux/include/asm-ppc/pgtable.h rb/include/asm-ppc/pgtable.h
--- linux/include/asm-ppc/pgtable.h	Sat Nov 11 21:23:11 2000
+++ rb/include/asm-ppc/pgtable.h	Sun Jan  7 13:31:53 2001
@@ -488,6 +488,6 @@
 
 #include <asm-generic/pgtable.h>
 
-#endif __ASSEMBLY__
+#endif	/* __ASSEMBLY__ */
 #endif /* _PPC_PGTABLE_H */
 #endif /* __KERNEL__ */
diff -urN -X dontdiff linux/include/asm-ppc/raven.h rb/include/asm-ppc/raven.h
--- linux/include/asm-ppc/raven.h	Sat Nov 11 21:23:11 2000
+++ rb/include/asm-ppc/raven.h	Sun Jan  7 13:31:54 2001
@@ -31,5 +31,5 @@
 extern struct hw_interrupt_type raven_pic;
 
 extern int raven_init(void);
-#endif _ASMPPC_RAVEN_H
+#endif	/* _ASMPPC_RAVEN_H */
 #endif /* __KERNEL__ */
diff -urN -X dontdiff linux/include/asm-s390/sigp.h rb/include/asm-s390/sigp.h
--- linux/include/asm-s390/sigp.h	Fri May 12 13:41:44 2000
+++ rb/include/asm-s390/sigp.h	Sun Jan  7 13:32:02 2001
@@ -249,6 +249,6 @@
    return ccode;
 }
 
-#endif __SIGP__
+#endif	/* __SIGP__ */
 
 
diff -urN -X dontdiff linux/include/asm-sparc64/a.out.h rb/include/asm-sparc64/a.out.h
--- linux/include/asm-sparc64/a.out.h	Fri Aug  6 13:58:00 1999
+++ rb/include/asm-sparc64/a.out.h	Sun Jan  7 13:31:54 2001
@@ -21,7 +21,7 @@
 	unsigned int a_drsize;
 };
 
-#endif __ASSEMBLY__
+#endif	/* __ASSEMBLY__ */
 
 /* Where in the file does the text information begin? */
 #define N_TXTOFF(x)     (N_MAGIC(x) == ZMAGIC ? 0 : sizeof (struct exec))
diff -urN -X dontdiff linux/include/linux/802_11.h rb/include/linux/802_11.h
--- linux/include/linux/802_11.h	Mon Dec 11 16:00:51 2000
+++ rb/include/linux/802_11.h	Sun Jan  7 13:31:48 2001
@@ -188,4 +188,4 @@
 }
 
 
-#endif
\ No newline at end of file
+#endif
diff -urN -X dontdiff linux/include/linux/coda_cache.h rb/include/linux/coda_cache.h
--- linux/include/linux/coda_cache.h	Tue Sep 19 17:08:59 2000
+++ rb/include/linux/coda_cache.h	Sun Jan  7 13:31:48 2001
@@ -19,4 +19,4 @@
 /* for downcalls and attributes and lookups */
 void coda_flag_inode_children(struct inode *inode, int flag);
 
-#endif _CFSNC_HEADER_
+#endif	/* _CFSNC_HEADER_ */
diff -urN -X dontdiff linux/include/linux/wavefront.h rb/include/linux/wavefront.h
--- linux/include/linux/wavefront.h	Mon Jan  4 14:42:43 1999
+++ rb/include/linux/wavefront.h	Sun Jan  7 13:31:48 2001
@@ -31,7 +31,7 @@
 	member, which has the same semantics anyway. 
      */
 
-#endif __GNUC__
+#endif	/* __GNUC__ */
 
 /***************************** WARNING ********************************
   PLEASE DO NOT MODIFY THIS FILE IN ANY WAY THAT AFFECTS ITS ABILITY TO 
@@ -40,11 +40,11 @@
 
 #ifndef NUM_MIDIKEYS 
 #define NUM_MIDIKEYS 128
-#endif  NUM_MIDIKEYS
+#endif	/* NUM_MIDIKEYS */
 
 #ifndef NUM_MIDICHANNELS
 #define NUM_MIDICHANNELS 16
-#endif  NUM_MIDICHANNELS
+#endif	/* NUM_MIDICHANNELS */
 
 /* These are very useful/important. the original wavefront interface
    was developed on a 16 bit system, where sizeof(int) = 2
@@ -672,4 +672,4 @@
 
 #define WFFX_MEMSET              69
 
-#endif __wavefront_h__
+#endif	/* __wavefront_h__ */
diff -urN -X dontdiff linux/net/irda/irnet/irnet.h rb/net/irda/irnet/irnet.h
--- linux/net/irda/irnet/irnet.h	Mon Dec 11 16:33:14 2000
+++ rb/net/irda/irnet/irnet.h	Sun Jan  7 13:32:33 2001
@@ -375,7 +375,7 @@
   struct irda_device_info *discoveries;	/* Copy of the discovery log */
   int			disco_index;	/* Last read in the discovery log */
   int			disco_number;	/* Size of the discovery log */
-#endif INITIAL_DISCOVERY
+#endif	/* INITIAL_DISCOVERY */
 
 } irnet_socket;
 
@@ -450,4 +450,4 @@
 /* Control channel stuff - allocated in irnet_irda.h */
 extern struct irnet_ctrl_channel	irnet_events;
 
-#endif IRNET_H
+#endif	/* IRNET_H */
diff -urN -X dontdiff linux/net/irda/irnet/irnet_irda.c rb/net/irda/irnet/irnet_irda.c
--- linux/net/irda/irnet/irnet_irda.c	Sun Nov 12 23:40:42 2000
+++ rb/net/irda/irnet/irnet_irda.c	Sun Jan  7 13:32:33 2001
@@ -382,7 +382,7 @@
   self->mask = 0xffff;		/* For W2k compatibility */
 #else DISCOVERY_NOMASK
   self->mask = irlmp_service_to_hint(S_LAN);
-#endif DISCOVERY_NOMASK
+#endif	/* DISCOVERY_NOMASK */
   self->tx_flow = FLOW_START;	/* Flow control from IrTTP */
 
   DEXIT(IRDA_SOCK_TRACE, "\n");
@@ -692,7 +692,7 @@
   /* If we want to receive "stream sockets" */
   if(max_sdu_size == 0)
     new->max_data_size = irttp_get_max_seg_size(new->tsap);
-#endif STREAM_COMPAT
+#endif	/* STREAM_COMPAT */
 
   /* Clean up the original one to keep it in listen state */
   self->tsap->dtsap_sel = self->tsap->lsap->dlsap_sel = LSAP_ANY;
@@ -708,7 +708,7 @@
    * Also, not doing it give IrDA a chance to finish the setup properly
    * before beeing swamped with packets... */
   ppp_output_wakeup(&new->chan);
-#endif CONNECT_INDIC_KICK
+#endif	/* CONNECT_INDIC_KICK */
 
   /* Notify the control channel */
   irnet_post_event(new, IRNET_CONNECT_FROM, new->daddr, self->rname);
@@ -738,7 +738,7 @@
   /* Hum... Is it the right thing to do ? And do we need to send
    * a connect response before ? It looks ok without this... */
   irttp_disconnect_request(self->tsap, NULL, P_NORMAL);
-#endif FAIL_SEND_DISCONNECT
+#endif	/* FAIL_SEND_DISCONNECT */
 
   /* Clean up the server to keep it in listen state */
   self->tsap->dtsap_sel = self->tsap->lsap->dlsap_sel = LSAP_ANY;
@@ -788,7 +788,7 @@
 #ifdef ADVERTISE_HINT
   /* Register with IrLMP as a service (advertise our hint bit) */
   irnet_server.skey = irlmp_register_service(hints);
-#endif ADVERTISE_HINT
+#endif	/* ADVERTISE_HINT */
 
   /* Register with LM-IAS (so that people can connect to us) */
   irnet_server.ias_obj = irias_new_object(IRNET_SERVICE_NAME, jiffies);
@@ -823,7 +823,7 @@
 #ifdef ADVERTISE_HINT
   /* Unregister with IrLMP */
   irlmp_unregister_service(irnet_server.skey);
-#endif ADVERTISE_HINT
+#endif	/* ADVERTISE_HINT */
 
   /* Unregister with LM-IAS */
   if(irnet_server.ias_obj)
@@ -995,7 +995,7 @@
 #ifdef STREAM_COMPAT
   if(max_sdu_size == 0)
     self->max_data_size = irttp_get_max_seg_size(self->tsap);
-#endif STREAM_COMPAT
+#endif	/* STREAM_COMPAT */
 
   /* At this point, IrLMP has assigned our source address */
   self->saddr = irttp_get_saddr(self->tsap);
@@ -1015,7 +1015,7 @@
 #else PASS_CONNECT_PACKETS
       DERROR(IRDA_CB_ERROR, "Dropping non empty packet.\n");
       kfree_skb(skb);	/* Note : will be optimised with other kfree... */
-#endif PASS_CONNECT_PACKETS
+#endif	/* PASS_CONNECT_PACKETS */
     }
   else
     kfree_skb(skb);
@@ -1160,7 +1160,7 @@
 #else ALLOW_SIMULT_CONNECT
       irnet_disconnect_server(self, skb);
       return;
-#endif ALLOW_SIMULT_CONNECT
+#endif	/* ALLOW_SIMULT_CONNECT */
     }
 
   /* So : at this point, we have a socket, and it is idle. Good ! */
@@ -1176,7 +1176,7 @@
 #else PASS_CONNECT_PACKETS
       DERROR(IRDA_CB_ERROR, "Dropping non empty packet.\n");
       kfree_skb(skb);	/* Note : will be optimised with other kfree... */
-#endif PASS_CONNECT_PACKETS
+#endif	/* PASS_CONNECT_PACKETS */
     }
   else
     kfree_skb(skb);
@@ -1312,7 +1312,7 @@
 
   DEXIT(IRDA_OCB_TRACE, "\n");
 }
-#endif DISCOVERY_EVENTS
+#endif	/* DISCOVERY_EVENTS */
 
 
 /*********************** PROC ENTRY CALLBACKS ***********************/
@@ -1469,7 +1469,7 @@
 #ifdef CONFIG_PROC_FS
   /* Remove our /proc file */
   remove_proc_entry("irnet", proc_irda);
-#endif CONFIG_PROC_FS
+#endif	/* CONFIG_PROC_FS */
 
   /* Remove our IrNET server from existence */
   irnet_destroy_server();
diff -urN -X dontdiff linux/net/irda/irnet/irnet_irda.h rb/net/irda/irnet/irnet_irda.h
--- linux/net/irda/irnet/irnet_irda.h	Mon Dec 11 16:33:15 2000
+++ rb/net/irda/irnet/irnet_irda.h	Sun Jan  7 13:32:33 2001
@@ -149,7 +149,7 @@
 			char **,
 			off_t,
 			int);
-#endif CONFIG_PROC_FS
+#endif	/* CONFIG_PROC_FS */
 
 /**************************** VARIABLES ****************************/
 
@@ -164,6 +164,6 @@
 /* The /proc/net/irda directory, defined elsewhere... */
 #ifdef CONFIG_PROC_FS
 extern struct proc_dir_entry *proc_irda;
-#endif CONFIG_PROC_FS
+#endif	/* CONFIG_PROC_FS */
 
-#endif IRNET_IRDA_H
+#endif	/* IRNET_IRDA_H */
diff -urN -X dontdiff linux/net/irda/irnet/irnet_ppp.c rb/net/irda/irnet/irnet_ppp.c
--- linux/net/irda/irnet/irnet_ppp.c	Sat Nov 11 21:11:23 2000
+++ rb/net/irda/irnet/irnet_ppp.c	Sun Jan  7 13:32:33 2001
@@ -186,7 +186,7 @@
 
   return done_event;
 }
-#endif INITIAL_DISCOVERY
+#endif	/* INITIAL_DISCOVERY */
 
 /*------------------------------------------------------------------*/
 /*
@@ -221,7 +221,7 @@
       DEXIT(CTRL_TRACE, "\n");
       return(strlen(event));
     }
-#endif INITIAL_DISCOVERY
+#endif	/* INITIAL_DISCOVERY */
 
   /* Put ourselves on the wait queue to be woken up */
   add_wait_queue(&irnet_events.rwait, &wait);
@@ -346,7 +346,7 @@
 #ifdef INITIAL_DISCOVERY
   if(ap->disco_number != -1)
     mask |= POLLIN | POLLRDNORM;
-#endif INITIAL_DISCOVERY
+#endif	/* INITIAL_DISCOVERY */
 
   DEXIT(CTRL_TRACE, " - mask=0x%X\n", mask);
   return mask;
@@ -379,7 +379,7 @@
   /* This could (should?) be enforced by the permissions on /dev/irnet. */
   if(!capable(CAP_NET_ADMIN))
     return -EPERM;
-#endif SECURE_DEVIRNET
+#endif	/* SECURE_DEVIRNET */
 
   /* Allocate a private structure for this IrNET instance */
   ap = kmalloc(sizeof(*ap), GFP_KERNEL);
@@ -556,7 +556,7 @@
 #ifdef SECURE_DEVIRNET
   if(!capable(CAP_NET_ADMIN))
     return -EPERM;
-#endif SECURE_DEVIRNET
+#endif	/* SECURE_DEVIRNET */
 
   err = -EFAULT;
   switch(cmd)
@@ -683,7 +683,7 @@
        * we get rid of our own buffers */
 #ifdef FLUSH_TO_PPP
       ppp_output_wakeup(&ap->chan);
-#endif FLUSH_TO_PPP
+#endif	/* FLUSH_TO_PPP */
       err = 0;
       break;
 
@@ -811,7 +811,7 @@
        * go through interruptible_sleep_on() in irnet_find_lsap_sel()
        * We need to find another way... */
       irda_irnet_connect(self);
-#endif CONNECT_IN_SEND
+#endif	/* CONNECT_IN_SEND */
 
       DEBUG(PPP_INFO, "IrTTP not ready ! (%d-0x%X)\n",
 	    self->ttp_open, (unsigned int) self->tsap);
@@ -842,7 +842,7 @@
 	  /* Blocking packet, ppp_generic will retry later */
 	  return 0;
 	}
-#endif BLOCK_WHEN_CONNECT
+#endif	/* BLOCK_WHEN_CONNECT */
 
       /* Dropping packet, pppd will retry later */
       dev_kfree_skb(skb);
diff -urN -X dontdiff linux/net/irda/irnet/irnet_ppp.h rb/net/irda/irnet/irnet_ppp.h
--- linux/net/irda/irnet/irnet_ppp.h	Mon Dec 11 16:33:14 2000
+++ rb/net/irda/irnet/irnet_ppp.h	Sun Jan  7 13:32:33 2001
@@ -27,8 +27,8 @@
  * Should be defined in <linux/if_ppp.h> */
 #ifndef PPPIOCSLINKNAME
 #define PPPIOCSLINKNAME	_IOW('t', 74, struct ppp_option_data)
-#endif PPPIOCSLINKNAME
-#endif LINKNAME_IOCTL
+#endif	/* PPPIOCSLINKNAME */
+#endif	/* LINKNAME_IOCTL */
 
 /* PPP hardcore stuff */
 
@@ -127,4 +127,4 @@
   ppp_irnet_ioctl
 };
 
-#endif IRNET_PPP_H
+#endif	/* IRNET_PPP_H */
diff -urN -X dontdiff linux/net/irda/qos.c rb/net/irda/qos.c
--- linux/net/irda/qos.c	Sat Nov 11 21:11:23 2000
+++ rb/net/irda/qos.c	Sun Jan  7 13:32:33 2001
@@ -258,7 +258,7 @@
 			WARNING(__FUNCTION__ "(), nothing more we can do!\n");
 		}
 	}
-#endif CONFIG_IRDA_DYNAMIC_WINDOW
+#endif	/* CONFIG_IRDA_DYNAMIC_WINDOW */
 }
 
 /*
diff -urN -X dontdiff linux/net/khttpd/security.h rb/net/khttpd/security.h
--- linux/net/khttpd/security.h	Wed Aug 18 11:45:10 1999
+++ rb/net/khttpd/security.h	Sun Jan  7 13:32:33 2001
@@ -9,4 +9,4 @@
 	char value[32-sizeof(void*)];  /* fill 1 cache-line */
 };
 
-#endif
\ No newline at end of file
+#endif


--Message-Boundary-8628--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
