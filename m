Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264097AbTFHAYs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 20:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264091AbTFHAYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 20:24:48 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73]:27593
	"EHLO michonline.com") by vger.kernel.org with ESMTP
	id S264097AbTFHAYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 20:24:22 -0400
Date: Sat, 7 Jun 2003 20:43:35 -0400
From: Ryan Anderson <ryan@michonline.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: kernel-janitor-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Subject: [PATCH][SPARSE] Make all the anonymous structures truly anonymous
Message-ID: <20030608004335.GG20872@michonline.com>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	kernel-janitor-discuss@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the type-names on the anonymous structures.  This
fixes compilation when using gcc-3.3 (Debian).  Credit for identifying
the fix goes to Arnaldo Carvalho de Melo <acme@conectiva.com.br>.

# This is a BitKeeper generated patch for the following project:
# Project Name: TSCT - The Silly C Tokenizer
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.354   -> 1.355  
#	             parse.h	1.35    -> 1.36   
#	            symbol.h	1.66    -> 1.67   
#	        expression.h	1.26    -> 1.27   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/06/07	ryan@mythryan2.(none)	1.355
# Fix anonymous structures to be truly anonymous. 
# (Fixes compile errors with gcc-3.2)
# --------------------------------------------
#
diff -Nru a/expression.h b/expression.h
--- a/expression.h	Sat Jun  7 16:43:52 2003
+++ b/expression.h	Sat Jun  7 16:43:52 2003
@@ -53,7 +53,7 @@
 		struct expression *unop;
 
 		// EXPR_SYMBOL
-		struct symbol_arg {
+		struct /* symbol_arg */ {
 			struct symbol *symbol;
 			struct ident *symbol_name;
 		};
@@ -62,35 +62,35 @@
 		struct statement *statement;
 
 		// EXPR_BINOP, EXPR_COMMA, EXPR_COMPARE, EXPR_LOGICAL and EXPR_ASSIGNMENT
-		struct binop_arg {
+		struct /* binop_arg */ {
 			struct expression *left, *right;
 		};
 		// EXPR_DEREF
-		struct deref_arg {
+		struct /* deref_arg */ {
 			struct expression *deref;
 			struct ident *member;
 		};
 		// EXPR_CAST and EXPR_SIZEOF
-		struct cast_arg {
+		struct /* cast_arg */ {
 			struct symbol *cast_type;
 			struct expression *cast_expression;
 		};
 		// EXPR_CONDITIONAL
-		struct conditional_expr {
+		struct /* conditional_expr */ {
 			struct expression *conditional, *cond_true, *cond_false;
 		};
 		// EXPR_CALL
-		struct call_expr {
+		struct /* call_expr */ {
 			struct expression *fn;
 			struct expression_list *args;
 		};
 		// EXPR_BITFIELD
-		struct bitfield_expr {
+		struct /* bitfield_expr */ {
 			unsigned char bitpos, nrbits;
 			struct expression *address;
 		};
 		// EXPR_LABEL
-		struct label_expr {
+		struct /* label_expr */ {
 			struct symbol *label_symbol;
 		};
 		// EXPR_INITIALIZER
@@ -98,11 +98,11 @@
 		// EXPR_IDENTIFIER
 		struct ident *expr_ident;
 		// EXPR_INDEX
-		struct index_expr {
+		struct /* index_expr */ {
 			unsigned int idx_from, idx_to;
 		};
 		// EXPR_POS
-		struct initpos_expr {
+		struct /* initpos_expr */ {
 			unsigned int init_offset;
 			struct symbol *init_sym;
 			struct expression *init_expr;
diff -Nru a/parse.h b/parse.h
--- a/parse.h	Sat Jun  7 16:43:52 2003
+++ b/parse.h	Sat Jun  7 16:43:52 2003
@@ -28,41 +28,41 @@
 	enum statement_type type;
 	struct position pos;
 	union {
-		struct label_arg {
+		struct /* label_arg */ {
 			struct symbol *label;
 			struct statement *label_statement;
 		};
 		struct expression *expression;
-		struct return_statement {
+		struct /* return_statement */ {
 			struct expression *ret_value;
 			struct symbol *ret_target;
 		};
-		struct if_statement {
+		struct /* if_statement */ {
 			struct expression *if_conditional;
 			struct statement *if_true;
 			struct statement *if_false;
 		};
-		struct compound_struct {
+		struct /* compound_struct */ {
 			struct symbol_list *syms;
 			struct statement_list *stmts;
 			struct symbol *ret;
 		};
-		struct labeled_struct {
+		struct /* labeled_struct */ {
 			struct symbol *label_identifier;
 			struct statement *label_statement;
 		};
-		struct case_struct {
+		struct /* case_struct */ {
 			struct expression *case_expression;
 			struct expression *case_to;
 			struct statement *case_statement;
 			struct symbol *case_label;
 		};
-		struct switch_struct {
+		struct /* switch_struct */ {
 			struct expression *switch_expression;
 			struct statement *switch_statement;
 			struct symbol *switch_break, *switch_case;
 		};
-		struct iterator_struct {
+		struct /* iterator_struct */ {
 			struct symbol *iterator_break;
 			struct symbol *iterator_continue;
 			struct symbol_list *iterator_syms;
@@ -74,7 +74,7 @@
 			struct statement  *iterator_post_statement;
 			struct expression *iterator_post_condition;
 		};
-		struct goto_struct {
+		struct /* goto_struct */ {
 			struct symbol *goto_label;
 			struct expression *goto_expression;
 		};
diff -Nru a/symbol.h b/symbol.h
--- a/symbol.h	Sat Jun  7 16:43:52 2003
+++ b/symbol.h	Sat Jun  7 16:43:52 2003
@@ -67,12 +67,12 @@
 	struct symbol	*same_symbol;
 	int (*evaluate)(struct expression *);
 
-	struct preprocessor_sym {
+	struct /* preprocessor_sym */ {
 		struct token *expansion;
 		struct token *arglist;
 	};
 	
-	struct ctype_sym {
+	struct /* ctype_sym */ {
 		unsigned long	offset;
 		unsigned int	bit_size;
 		unsigned int	bit_offset:8,

-- 

Ryan Anderson
  sometimes Pug Majere
