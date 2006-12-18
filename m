Return-Path: <linux-kernel-owner+w=401wt.eu-S1751561AbWLRSEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751561AbWLRSEv (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 13:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752652AbWLRSEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 13:04:51 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:2518 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751561AbWLRSEt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 13:04:49 -0500
Date: Mon, 18 Dec 2006 19:04:47 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "Robert P. J. Day" <rpjday@mindspring.com>, zippel@linux-m68k.org
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       kbuild-devel@lists.sourceforge.net
Subject: [2.6 patch] kconfig: remove the unused "requires" syntax
Message-ID: <20061218180447.GF10316@stusta.de>
References: <Pine.LNX.4.64.0612181138360.27491@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612181138360.27491@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 18, 2006 at 11:41:59AM -0500, Robert P. J. Day wrote:
> 
>   Remove the note in the documentation that suggests people can use
> "requires" for dependencies in Kconfig files.
>...

Considering that noone uses it, what about the patch below to also 
remove the implementation?

cu
Adrian


<--  snip  -->


This patch removes the "requires" from the Kconfig language that was an 
unused alternative to "depends on".

The size of this patch comes from the generated files that are changed.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 Documentation/kbuild/kconfig-language.txt |    2 
 scripts/kconfig/lex.zconf.c_shipped       |    4 
 scripts/kconfig/zconf.gperf               |    1 
 scripts/kconfig/zconf.hash.c_shipped      |   10 
 scripts/kconfig/zconf.tab.c_shipped       | 1397 ++++++++++++----------
 scripts/kconfig/zconf.y                   |    6 
 6 files changed, 777 insertions(+), 643 deletions(-)

diff --git a/Documentation/kbuild/kconfig-language.txt b/Documentation/kbuild/kconfig-language.txt
index 536d5bf..658abb5 100644
--- a/Documentation/kbuild/kconfig-language.txt
+++ b/Documentation/kbuild/kconfig-language.txt
@@ -77,7 +77,7 @@ applicable everywhere (see syntax).
   Optionally, dependencies only for this default value can be added with
   "if".
 
-- dependencies: "depends on"/"requires" <expr>
+- dependencies: "depends on" <expr>
   This defines a dependency for this menu entry. If multiple
   dependencies are defined, they are connected with '&&'. Dependencies
   are applied to all other options within this menu entry (which also
diff --git a/scripts/kconfig/lex.zconf.c_shipped b/scripts/kconfig/lex.zconf.c_shipped
index 800f8c7..05c37f0 100644
--- a/scripts/kconfig/lex.zconf.c_shipped
+++ b/scripts/kconfig/lex.zconf.c_shipped
@@ -33,7 +33,7 @@
 #if __STDC_VERSION__ >= 199901L
 
 /* C99 says to define __STDC_LIMIT_MACROS before including stdint.h,
- * if you want the limit (max/min) macros for int types.
+ * if you want the limit (max/min) macros for int types. 
  */
 #ifndef __STDC_LIMIT_MACROS
 #define __STDC_LIMIT_MACROS 1
@@ -1511,7 +1511,7 @@ static int yy_get_next_buffer (void)
 
 		/* Read in more data. */
 		YY_INPUT( (&YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[number_to_move]),
-			(yy_n_chars), num_to_read );
+			(yy_n_chars), (size_t) num_to_read );
 
 		YY_CURRENT_BUFFER_LVALUE->yy_n_chars = (yy_n_chars);
 		}
diff --git a/scripts/kconfig/zconf.gperf b/scripts/kconfig/zconf.gperf
index 9b44c80..a6a2740 100644
--- a/scripts/kconfig/zconf.gperf
+++ b/scripts/kconfig/zconf.gperf
@@ -23,7 +23,6 @@ help,		T_HELP,		TF_COMMAND
 if,		T_IF,		TF_COMMAND|TF_PARAM
 endif,		T_ENDIF,	TF_COMMAND
 depends,	T_DEPENDS,	TF_COMMAND
-requires,	T_REQUIRES,	TF_COMMAND
 optional,	T_OPTIONAL,	TF_COMMAND
 default,	T_DEFAULT,	TF_COMMAND, S_UNKNOWN
 prompt,		T_PROMPT,	TF_COMMAND
diff --git a/scripts/kconfig/zconf.hash.c_shipped b/scripts/kconfig/zconf.hash.c_shipped
index 47c8b5b..a707c53 100644
--- a/scripts/kconfig/zconf.hash.c_shipped
+++ b/scripts/kconfig/zconf.hash.c_shipped
@@ -1,4 +1,4 @@
-/* ANSI-C code produced by gperf version 3.0.1 */
+/* ANSI-C code produced by gperf version 3.0.2 */
 /* Command-line: gperf  */
 /* Computed positions: -k'1,3' */
 
@@ -55,7 +55,7 @@ kconf_id_hash (register const char *str, register unsigned int len)
       47, 47, 47, 47, 47, 47, 47, 47, 47, 47,
       47, 47, 47, 47, 47, 47, 47, 25, 30, 15,
        0, 15,  0, 47,  5, 15, 47, 47, 30, 20,
-       5,  0, 25, 15,  0,  0, 10, 35, 47, 47,
+       5,  0, 25, 47,  0,  0, 10, 35, 47, 47,
        5, 47, 47, 47, 47, 47, 47, 47, 47, 47,
       47, 47, 47, 47, 47, 47, 47, 47, 47, 47,
       47, 47, 47, 47, 47, 47, 47, 47, 47, 47,
@@ -103,7 +103,6 @@ struct kconf_id_strings_t
     char kconf_id_strings_str20[sizeof("endif")];
     char kconf_id_strings_str21[sizeof("choice")];
     char kconf_id_strings_str22[sizeof("endmenu")];
-    char kconf_id_strings_str23[sizeof("requires")];
     char kconf_id_strings_str24[sizeof("endchoice")];
     char kconf_id_strings_str26[sizeof("config")];
     char kconf_id_strings_str27[sizeof("modules")];
@@ -139,7 +138,6 @@ static struct kconf_id_strings_t kconf_id_strings_contents =
     "endif",
     "choice",
     "endmenu",
-    "requires",
     "endchoice",
     "config",
     "modules",
@@ -167,7 +165,7 @@ kconf_id_lookup (register const char *str, register unsigned int len)
 {
   enum
     {
-      TOTAL_KEYWORDS = 33,
+      TOTAL_KEYWORDS = 32,
       MIN_WORD_LENGTH = 2,
       MAX_WORD_LENGTH = 14,
       MIN_HASH_VALUE = 2,
@@ -196,7 +194,7 @@ kconf_id_lookup (register const char *str, register unsigned int len)
       {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str20,		T_ENDIF,	TF_COMMAND},
       {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str21,		T_CHOICE,	TF_COMMAND},
       {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str22,	T_ENDMENU,	TF_COMMAND},
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str23,	T_REQUIRES,	TF_COMMAND},
+      {-1},
       {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str24,	T_ENDCHOICE,	TF_COMMAND},
       {-1},
       {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str26,		T_CONFIG,	TF_COMMAND},
diff --git a/scripts/kconfig/zconf.tab.c_shipped b/scripts/kconfig/zconf.tab.c_shipped
index d777fe8..2ad1b5c 100644
--- a/scripts/kconfig/zconf.tab.c_shipped
+++ b/scripts/kconfig/zconf.tab.c_shipped
@@ -1,7 +1,9 @@
-/* A Bison parser, made by GNU Bison 2.1.  */
+/* A Bison parser, made by GNU Bison 2.3.  */
 
-/* Skeleton parser for Yacc-like parsing with Bison,
-   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005 Free Software Foundation, Inc.
+/* Skeleton implementation for Bison's Yacc-like parsers in C
+
+   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
+   Free Software Foundation, Inc.
 
    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
@@ -18,13 +20,21 @@
    Foundation, Inc., 51 Franklin Street, Fifth Floor,
    Boston, MA 02110-1301, USA.  */
 
-/* As a special exception, when this file is copied by Bison into a
-   Bison output file, you may use that output file without restriction.
-   This special exception was added by the Free Software Foundation
-   in version 1.24 of Bison.  */
+/* As a special exception, you may create a larger work that contains
+   part or all of the Bison parser skeleton and distribute that work
+   under terms of your choice, so long as that work isn't itself a
+   parser generator using the skeleton or a modified version thereof
+   as a parser skeleton.  Alternatively, if you modify or redistribute
+   the parser skeleton itself, you may (at your option) remove this
+   special exception, which will cause the skeleton and the resulting
+   Bison output files to be licensed under the GNU General Public
+   License without this special exception.
+
+   This special exception was added by the Free Software Foundation in
+   version 2.2 of Bison.  */
 
-/* Written by Richard Stallman by simplifying the original so called
-   ``semantic'' parser.  */
+/* C LALR(1) parser skeleton written by Richard Stallman, by
+   simplifying the original so-called "semantic" parser.  */
 
 /* All symbols defined below should begin with yy or YY, to avoid
    infringing on user name space.  This should be done even for local
@@ -37,7 +47,7 @@
 #define YYBISON 1
 
 /* Bison version.  */
-#define YYBISON_VERSION "2.1"
+#define YYBISON_VERSION "2.3"
 
 /* Skeleton name.  */
 #define YYSKELETON_NAME "yacc.c"
@@ -78,25 +88,24 @@
      T_IF = 269,
      T_ENDIF = 270,
      T_DEPENDS = 271,
-     T_REQUIRES = 272,
-     T_OPTIONAL = 273,
-     T_PROMPT = 274,
-     T_TYPE = 275,
-     T_DEFAULT = 276,
-     T_SELECT = 277,
-     T_RANGE = 278,
-     T_OPTION = 279,
-     T_ON = 280,
-     T_WORD = 281,
-     T_WORD_QUOTE = 282,
-     T_UNEQUAL = 283,
-     T_CLOSE_PAREN = 284,
-     T_OPEN_PAREN = 285,
-     T_EOL = 286,
-     T_OR = 287,
-     T_AND = 288,
-     T_EQUAL = 289,
-     T_NOT = 290
+     T_OPTIONAL = 272,
+     T_PROMPT = 273,
+     T_TYPE = 274,
+     T_DEFAULT = 275,
+     T_SELECT = 276,
+     T_RANGE = 277,
+     T_OPTION = 278,
+     T_ON = 279,
+     T_WORD = 280,
+     T_WORD_QUOTE = 281,
+     T_UNEQUAL = 282,
+     T_CLOSE_PAREN = 283,
+     T_OPEN_PAREN = 284,
+     T_EOL = 285,
+     T_OR = 286,
+     T_AND = 287,
+     T_EQUAL = 288,
+     T_NOT = 289
    };
 #endif
 /* Tokens.  */
@@ -114,25 +123,24 @@
 #define T_IF 269
 #define T_ENDIF 270
 #define T_DEPENDS 271
-#define T_REQUIRES 272
-#define T_OPTIONAL 273
-#define T_PROMPT 274
-#define T_TYPE 275
-#define T_DEFAULT 276
-#define T_SELECT 277
-#define T_RANGE 278
-#define T_OPTION 279
-#define T_ON 280
-#define T_WORD 281
-#define T_WORD_QUOTE 282
-#define T_UNEQUAL 283
-#define T_CLOSE_PAREN 284
-#define T_OPEN_PAREN 285
-#define T_EOL 286
-#define T_OR 287
-#define T_AND 288
-#define T_EQUAL 289
-#define T_NOT 290
+#define T_OPTIONAL 272
+#define T_PROMPT 273
+#define T_TYPE 274
+#define T_DEFAULT 275
+#define T_SELECT 276
+#define T_RANGE 277
+#define T_OPTION 278
+#define T_ON 279
+#define T_WORD 280
+#define T_WORD_QUOTE 281
+#define T_UNEQUAL 282
+#define T_CLOSE_PAREN 283
+#define T_OPEN_PAREN 284
+#define T_EOL 285
+#define T_OR 286
+#define T_AND 287
+#define T_EQUAL 288
+#define T_NOT 289
 
 
 
@@ -198,18 +206,20 @@ static struct menu *current_menu, *current_entry;
 # define YYTOKEN_TABLE 0
 #endif
 
-#if ! defined (YYSTYPE) && ! defined (YYSTYPE_IS_DECLARED)
+#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
+typedef union YYSTYPE
 
-typedef union YYSTYPE {
+{
 	char *string;
 	struct file *file;
 	struct symbol *symbol;
 	struct expr *expr;
 	struct menu *menu;
 	struct kconf_id *id;
-} YYSTYPE;
-/* Line 196 of yacc.c.  */
+}
+/* Line 187 of yacc.c.  */
 
+	YYSTYPE;
 # define yystype YYSTYPE /* obsolescent; will be withdrawn */
 # define YYSTYPE_IS_DECLARED 1
 # define YYSTYPE_IS_TRIVIAL 1
@@ -220,23 +230,56 @@ typedef union YYSTYPE {
 /* Copy the second part of user declarations.  */
 
 
-/* Line 219 of yacc.c.  */
+/* Line 216 of yacc.c.  */
+
+
+#ifdef short
+# undef short
+#endif
 
+#ifdef YYTYPE_UINT8
+typedef YYTYPE_UINT8 yytype_uint8;
+#else
+typedef unsigned char yytype_uint8;
+#endif
 
-#if ! defined (YYSIZE_T) && defined (__SIZE_TYPE__)
-# define YYSIZE_T __SIZE_TYPE__
+#ifdef YYTYPE_INT8
+typedef YYTYPE_INT8 yytype_int8;
+#elif (defined __STDC__ || defined __C99__FUNC__ \
+     || defined __cplusplus || defined _MSC_VER)
+typedef signed char yytype_int8;
+#else
+typedef short int yytype_int8;
 #endif
-#if ! defined (YYSIZE_T) && defined (size_t)
-# define YYSIZE_T size_t
+
+#ifdef YYTYPE_UINT16
+typedef YYTYPE_UINT16 yytype_uint16;
+#else
+typedef unsigned short int yytype_uint16;
 #endif
-#if ! defined (YYSIZE_T) && (defined (__STDC__) || defined (__cplusplus))
-# include <stddef.h> /* INFRINGES ON USER NAME SPACE */
-# define YYSIZE_T size_t
+
+#ifdef YYTYPE_INT16
+typedef YYTYPE_INT16 yytype_int16;
+#else
+typedef short int yytype_int16;
 #endif
-#if ! defined (YYSIZE_T)
-# define YYSIZE_T unsigned int
+
+#ifndef YYSIZE_T
+# ifdef __SIZE_TYPE__
+#  define YYSIZE_T __SIZE_TYPE__
+# elif defined size_t
+#  define YYSIZE_T size_t
+# elif ! defined YYSIZE_T && (defined __STDC__ || defined __C99__FUNC__ \
+     || defined __cplusplus || defined _MSC_VER)
+#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
+#  define YYSIZE_T size_t
+# else
+#  define YYSIZE_T unsigned int
+# endif
 #endif
 
+#define YYSIZE_MAXIMUM ((YYSIZE_T) -1)
+
 #ifndef YY_
 # if YYENABLE_NLS
 #  if ENABLE_NLS
@@ -249,7 +292,32 @@ typedef union YYSTYPE {
 # endif
 #endif
 
-#if ! defined (yyoverflow) || YYERROR_VERBOSE
+/* Suppress unused-variable warnings by "using" E.  */
+#if ! defined lint || defined __GNUC__
+# define YYUSE(e) ((void) (e))
+#else
+# define YYUSE(e) /* empty */
+#endif
+
+/* Identity function, used to suppress warnings about constant conditions.  */
+#ifndef lint
+# define YYID(n) (n)
+#else
+#if (defined __STDC__ || defined __C99__FUNC__ \
+     || defined __cplusplus || defined _MSC_VER)
+static int
+YYID (int i)
+#else
+static int
+YYID (i)
+    int i;
+#endif
+{
+  return i;
+}
+#endif
+
+#if ! defined yyoverflow || YYERROR_VERBOSE
 
 /* The parser invokes alloca or malloc; define the necessary symbols.  */
 
@@ -257,64 +325,76 @@ typedef union YYSTYPE {
 #  if YYSTACK_USE_ALLOCA
 #   ifdef __GNUC__
 #    define YYSTACK_ALLOC __builtin_alloca
+#   elif defined __BUILTIN_VA_ARG_INCR
+#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
+#   elif defined _AIX
+#    define YYSTACK_ALLOC __alloca
+#   elif defined _MSC_VER
+#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
+#    define alloca _alloca
 #   else
 #    define YYSTACK_ALLOC alloca
-#    if defined (__STDC__) || defined (__cplusplus)
+#    if ! defined _ALLOCA_H && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
+     || defined __cplusplus || defined _MSC_VER)
 #     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
-#     define YYINCLUDED_STDLIB_H
+#     ifndef _STDLIB_H
+#      define _STDLIB_H 1
+#     endif
 #    endif
 #   endif
 #  endif
 # endif
 
 # ifdef YYSTACK_ALLOC
-   /* Pacify GCC's `empty if-body' warning. */
-#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
+   /* Pacify GCC's `empty if-body' warning.  */
+#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (YYID (0))
 #  ifndef YYSTACK_ALLOC_MAXIMUM
     /* The OS might guarantee only one guard page at the bottom of the stack,
        and a page size can be as small as 4096 bytes.  So we cannot safely
        invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
        to allow for a few compiler-allocated temporary stack slots.  */
-#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2005 */
+#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
 #  endif
 # else
 #  define YYSTACK_ALLOC YYMALLOC
 #  define YYSTACK_FREE YYFREE
 #  ifndef YYSTACK_ALLOC_MAXIMUM
-#   define YYSTACK_ALLOC_MAXIMUM ((YYSIZE_T) -1)
+#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
 #  endif
-#  ifdef __cplusplus
-extern "C" {
+#  if (defined __cplusplus && ! defined _STDLIB_H \
+       && ! ((defined YYMALLOC || defined malloc) \
+	     && (defined YYFREE || defined free)))
+#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
+#   ifndef _STDLIB_H
+#    define _STDLIB_H 1
+#   endif
 #  endif
 #  ifndef YYMALLOC
 #   define YYMALLOC malloc
-#   if (! defined (malloc) && ! defined (YYINCLUDED_STDLIB_H) \
-	&& (defined (__STDC__) || defined (__cplusplus)))
+#   if ! defined malloc && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
+     || defined __cplusplus || defined _MSC_VER)
 void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
 #   endif
 #  endif
 #  ifndef YYFREE
 #   define YYFREE free
-#   if (! defined (free) && ! defined (YYINCLUDED_STDLIB_H) \
-	&& (defined (__STDC__) || defined (__cplusplus)))
+#   if ! defined free && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
+     || defined __cplusplus || defined _MSC_VER)
 void free (void *); /* INFRINGES ON USER NAME SPACE */
 #   endif
 #  endif
-#  ifdef __cplusplus
-}
-#  endif
 # endif
-#endif /* ! defined (yyoverflow) || YYERROR_VERBOSE */
+#endif /* ! defined yyoverflow || YYERROR_VERBOSE */
 
 
-#if (! defined (yyoverflow) \
-     && (! defined (__cplusplus) \
-	 || (defined (YYSTYPE_IS_TRIVIAL) && YYSTYPE_IS_TRIVIAL)))
+#if (! defined yyoverflow \
+     && (! defined __cplusplus \
+	 || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))
 
 /* A type that is properly aligned for any stack member.  */
 union yyalloc
 {
-  short int yyss;
+  yytype_int16 yyss;
   YYSTYPE yyvs;
   };
 
@@ -324,13 +404,13 @@ union yyalloc
 /* The size of an array large to enough to hold all stacks, each with
    N elements.  */
 # define YYSTACK_BYTES(N) \
-     ((N) * (sizeof (short int) + sizeof (YYSTYPE))			\
+     ((N) * (sizeof (yytype_int16) + sizeof (YYSTYPE)) \
       + YYSTACK_GAP_MAXIMUM)
 
 /* Copy COUNT objects from FROM to TO.  The source and destination do
    not overlap.  */
 # ifndef YYCOPY
-#  if defined (__GNUC__) && 1 < __GNUC__
+#  if defined __GNUC__ && 1 < __GNUC__
 #   define YYCOPY(To, From, Count) \
       __builtin_memcpy (To, From, (Count) * sizeof (*(From)))
 #  else
@@ -341,7 +421,7 @@ union yyalloc
 	  for (yyi = 0; yyi < (Count); yyi++)	\
 	    (To)[yyi] = (From)[yyi];		\
 	}					\
-      while (0)
+      while (YYID (0))
 #  endif
 # endif
 
@@ -359,39 +439,33 @@ union yyalloc
 	yynewbytes = yystacksize * sizeof (*Stack) + YYSTACK_GAP_MAXIMUM; \
 	yyptr += yynewbytes / sizeof (*yyptr);				\
       }									\
-    while (0)
+    while (YYID (0))
 
 #endif
 
-#if defined (__STDC__) || defined (__cplusplus)
-   typedef signed char yysigned_char;
-#else
-   typedef short int yysigned_char;
-#endif
-
-/* YYFINAL -- State number of the termination state. */
+/* YYFINAL -- State number of the termination state.  */
 #define YYFINAL  3
 /* YYLAST -- Last index in YYTABLE.  */
-#define YYLAST   275
+#define YYLAST   266
 
-/* YYNTOKENS -- Number of terminals. */
-#define YYNTOKENS  36
-/* YYNNTS -- Number of nonterminals. */
+/* YYNTOKENS -- Number of terminals.  */
+#define YYNTOKENS  35
+/* YYNNTS -- Number of nonterminals.  */
 #define YYNNTS  45
-/* YYNRULES -- Number of rules. */
-#define YYNRULES  110
-/* YYNRULES -- Number of states. */
-#define YYNSTATES  183
+/* YYNRULES -- Number of rules.  */
+#define YYNRULES  109
+/* YYNRULES -- Number of states.  */
+#define YYNSTATES  180
 
 /* YYTRANSLATE(YYLEX) -- Bison symbol number corresponding to YYLEX.  */
 #define YYUNDEFTOK  2
-#define YYMAXUTOK   290
+#define YYMAXUTOK   289
 
 #define YYTRANSLATE(YYX)						\
   ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)
 
 /* YYTRANSLATE[YYLEX] -- Bison symbol number corresponding to YYLEX.  */
-static const unsigned char yytranslate[] =
+static const yytype_uint8 yytranslate[] =
 {
        0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
        2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
@@ -421,14 +495,13 @@ static const unsigned char yytranslate[] =
        2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
        5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
       15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
-      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
-      35
+      25,    26,    27,    28,    29,    30,    31,    32,    33,    34
 };
 
 #if YYDEBUG
 /* YYPRHS[YYN] -- Index of the first RHS symbol of rule number YYN in
    YYRHS.  */
-static const unsigned short int yyprhs[] =
+static const yytype_uint16 yyprhs[] =
 {
        0,     0,     3,     5,     6,     9,    12,    15,    20,    23,
       28,    33,    37,    39,    41,    43,    45,    47,    49,    51,
@@ -439,80 +512,78 @@ static const unsigned short int yyprhs[] =
      178,   181,   186,   187,   190,   194,   196,   200,   201,   204,
      207,   210,   214,   217,   219,   223,   224,   227,   230,   233,
      237,   241,   244,   247,   250,   251,   254,   257,   260,   265,
-     269,   273,   274,   277,   279,   281,   284,   287,   290,   292,
-     295,   296,   299,   301,   305,   309,   313,   316,   320,   324,
-     326
+     269,   270,   273,   275,   277,   280,   283,   286,   288,   291,
+     292,   295,   297,   301,   305,   309,   312,   316,   320,   322
 };
 
-/* YYRHS -- A `-1'-separated list of the rules' RHS. */
-static const yysigned_char yyrhs[] =
+/* YYRHS -- A `-1'-separated list of the rules' RHS.  */
+static const yytype_int8 yyrhs[] =
 {
-      37,     0,    -1,    38,    -1,    -1,    38,    40,    -1,    38,
-      54,    -1,    38,    65,    -1,    38,     3,    75,    77,    -1,
-      38,    76,    -1,    38,    26,     1,    31,    -1,    38,    39,
-       1,    31,    -1,    38,     1,    31,    -1,    16,    -1,    19,
-      -1,    20,    -1,    22,    -1,    18,    -1,    23,    -1,    21,
-      -1,    31,    -1,    60,    -1,    69,    -1,    43,    -1,    45,
-      -1,    67,    -1,    26,     1,    31,    -1,     1,    31,    -1,
-      10,    26,    31,    -1,    42,    46,    -1,    11,    26,    31,
-      -1,    44,    46,    -1,    -1,    46,    47,    -1,    46,    48,
-      -1,    46,    73,    -1,    46,    71,    -1,    46,    41,    -1,
-      46,    31,    -1,    20,    74,    31,    -1,    19,    75,    78,
-      31,    -1,    21,    79,    78,    31,    -1,    22,    26,    78,
-      31,    -1,    23,    80,    80,    78,    31,    -1,    24,    49,
-      31,    -1,    -1,    49,    26,    50,    -1,    -1,    34,    75,
-      -1,     7,    31,    -1,    51,    55,    -1,    76,    -1,    52,
-      57,    53,    -1,    -1,    55,    56,    -1,    55,    73,    -1,
-      55,    71,    -1,    55,    31,    -1,    55,    41,    -1,    19,
-      75,    78,    31,    -1,    20,    74,    31,    -1,    18,    31,
-      -1,    21,    26,    78,    31,    -1,    -1,    57,    40,    -1,
-      14,    79,    77,    -1,    76,    -1,    58,    61,    59,    -1,
-      -1,    61,    40,    -1,    61,    65,    -1,    61,    54,    -1,
-       4,    75,    31,    -1,    62,    72,    -1,    76,    -1,    63,
-      66,    64,    -1,    -1,    66,    40,    -1,    66,    65,    -1,
-      66,    54,    -1,     6,    75,    31,    -1,     9,    75,    31,
-      -1,    68,    72,    -1,    12,    31,    -1,    70,    13,    -1,
-      -1,    72,    73,    -1,    72,    31,    -1,    72,    41,    -1,
-      16,    25,    79,    31,    -1,    16,    79,    31,    -1,    17,
-      79,    31,    -1,    -1,    75,    78,    -1,    26,    -1,    27,
-      -1,     5,    31,    -1,     8,    31,    -1,    15,    31,    -1,
-      31,    -1,    77,    31,    -1,    -1,    14,    79,    -1,    80,
-      -1,    80,    34,    80,    -1,    80,    28,    80,    -1,    30,
-      79,    29,    -1,    35,    79,    -1,    79,    32,    79,    -1,
-      79,    33,    79,    -1,    26,    -1,    27,    -1
+      36,     0,    -1,    37,    -1,    -1,    37,    39,    -1,    37,
+      53,    -1,    37,    64,    -1,    37,     3,    74,    76,    -1,
+      37,    75,    -1,    37,    25,     1,    30,    -1,    37,    38,
+       1,    30,    -1,    37,     1,    30,    -1,    16,    -1,    18,
+      -1,    19,    -1,    21,    -1,    17,    -1,    22,    -1,    20,
+      -1,    30,    -1,    59,    -1,    68,    -1,    42,    -1,    44,
+      -1,    66,    -1,    25,     1,    30,    -1,     1,    30,    -1,
+      10,    25,    30,    -1,    41,    45,    -1,    11,    25,    30,
+      -1,    43,    45,    -1,    -1,    45,    46,    -1,    45,    47,
+      -1,    45,    72,    -1,    45,    70,    -1,    45,    40,    -1,
+      45,    30,    -1,    19,    73,    30,    -1,    18,    74,    77,
+      30,    -1,    20,    78,    77,    30,    -1,    21,    25,    77,
+      30,    -1,    22,    79,    79,    77,    30,    -1,    23,    48,
+      30,    -1,    -1,    48,    25,    49,    -1,    -1,    33,    74,
+      -1,     7,    30,    -1,    50,    54,    -1,    75,    -1,    51,
+      56,    52,    -1,    -1,    54,    55,    -1,    54,    72,    -1,
+      54,    70,    -1,    54,    30,    -1,    54,    40,    -1,    18,
+      74,    77,    30,    -1,    19,    73,    30,    -1,    17,    30,
+      -1,    20,    25,    77,    30,    -1,    -1,    56,    39,    -1,
+      14,    78,    76,    -1,    75,    -1,    57,    60,    58,    -1,
+      -1,    60,    39,    -1,    60,    64,    -1,    60,    53,    -1,
+       4,    74,    30,    -1,    61,    71,    -1,    75,    -1,    62,
+      65,    63,    -1,    -1,    65,    39,    -1,    65,    64,    -1,
+      65,    53,    -1,     6,    74,    30,    -1,     9,    74,    30,
+      -1,    67,    71,    -1,    12,    30,    -1,    69,    13,    -1,
+      -1,    71,    72,    -1,    71,    30,    -1,    71,    40,    -1,
+      16,    24,    78,    30,    -1,    16,    78,    30,    -1,    -1,
+      74,    77,    -1,    25,    -1,    26,    -1,     5,    30,    -1,
+       8,    30,    -1,    15,    30,    -1,    30,    -1,    76,    30,
+      -1,    -1,    14,    78,    -1,    79,    -1,    79,    33,    79,
+      -1,    79,    27,    79,    -1,    29,    78,    28,    -1,    34,
+      78,    -1,    78,    31,    78,    -1,    78,    32,    78,    -1,
+      25,    -1,    26,    -1
 };
 
 /* YYRLINE[YYN] -- source line where rule number YYN was defined.  */
-static const unsigned short int yyrline[] =
+static const yytype_uint16 yyrline[] =
 {
-       0,   105,   105,   107,   109,   110,   111,   112,   113,   114,
-     115,   119,   123,   123,   123,   123,   123,   123,   123,   127,
-     128,   129,   130,   131,   132,   136,   137,   143,   151,   157,
-     165,   175,   177,   178,   179,   180,   181,   182,   185,   193,
-     199,   209,   215,   221,   224,   226,   237,   238,   243,   252,
-     257,   265,   268,   270,   271,   272,   273,   274,   277,   283,
-     294,   300,   310,   312,   317,   325,   333,   336,   338,   339,
-     340,   345,   352,   357,   365,   368,   370,   371,   372,   375,
-     383,   390,   397,   403,   410,   412,   413,   414,   417,   422,
-     427,   435,   437,   442,   443,   446,   447,   448,   452,   453,
-     456,   457,   460,   461,   462,   463,   464,   465,   466,   469,
-     470
+       0,   104,   104,   106,   108,   109,   110,   111,   112,   113,
+     114,   118,   122,   122,   122,   122,   122,   122,   122,   126,
+     127,   128,   129,   130,   131,   135,   136,   142,   150,   156,
+     164,   174,   176,   177,   178,   179,   180,   181,   184,   192,
+     198,   208,   214,   220,   223,   225,   236,   237,   242,   251,
+     256,   264,   267,   269,   270,   271,   272,   273,   276,   282,
+     293,   299,   309,   311,   316,   324,   332,   335,   337,   338,
+     339,   344,   351,   356,   364,   367,   369,   370,   371,   374,
+     382,   389,   396,   402,   409,   411,   412,   413,   416,   421,
+     429,   431,   436,   437,   440,   441,   442,   446,   447,   450,
+     451,   454,   455,   456,   457,   458,   459,   460,   463,   464
 };
 #endif
 
 #if YYDEBUG || YYERROR_VERBOSE || YYTOKEN_TABLE
 /* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
-   First, the terminals, then, starting at YYNTOKENS, nonterminals. */
+   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
 static const char *const yytname[] =
 {
   "$end", "error", "$undefined", "T_MAINMENU", "T_MENU", "T_ENDMENU",
   "T_SOURCE", "T_CHOICE", "T_ENDCHOICE", "T_COMMENT", "T_CONFIG",
   "T_MENUCONFIG", "T_HELP", "T_HELPTEXT", "T_IF", "T_ENDIF", "T_DEPENDS",
-  "T_REQUIRES", "T_OPTIONAL", "T_PROMPT", "T_TYPE", "T_DEFAULT",
-  "T_SELECT", "T_RANGE", "T_OPTION", "T_ON", "T_WORD", "T_WORD_QUOTE",
-  "T_UNEQUAL", "T_CLOSE_PAREN", "T_OPEN_PAREN", "T_EOL", "T_OR", "T_AND",
-  "T_EQUAL", "T_NOT", "$accept", "input", "stmt_list", "option_name",
-  "common_stmt", "option_error", "config_entry_start", "config_stmt",
+  "T_OPTIONAL", "T_PROMPT", "T_TYPE", "T_DEFAULT", "T_SELECT", "T_RANGE",
+  "T_OPTION", "T_ON", "T_WORD", "T_WORD_QUOTE", "T_UNEQUAL",
+  "T_CLOSE_PAREN", "T_OPEN_PAREN", "T_EOL", "T_OR", "T_AND", "T_EQUAL",
+  "T_NOT", "$accept", "input", "stmt_list", "option_name", "common_stmt",
+  "option_error", "config_entry_start", "config_stmt",
   "menuconfig_entry_start", "menuconfig_stmt", "config_option_list",
   "config_option", "symbol_option", "symbol_option_list",
   "symbol_option_arg", "choice", "choice_entry", "choice_end",
@@ -527,34 +598,33 @@ static const char *const yytname[] =
 # ifdef YYPRINT
 /* YYTOKNUM[YYLEX-NUM] -- Internal token number corresponding to
    token YYLEX-NUM.  */
-static const unsigned short int yytoknum[] =
+static const yytype_uint16 yytoknum[] =
 {
        0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
      265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
      275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
-     285,   286,   287,   288,   289,   290
+     285,   286,   287,   288,   289
 };
 # endif
 
 /* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
-static const unsigned char yyr1[] =
+static const yytype_uint8 yyr1[] =
 {
-       0,    36,    37,    38,    38,    38,    38,    38,    38,    38,
-      38,    38,    39,    39,    39,    39,    39,    39,    39,    40,
-      40,    40,    40,    40,    40,    41,    41,    42,    43,    44,
-      45,    46,    46,    46,    46,    46,    46,    46,    47,    47,
-      47,    47,    47,    48,    49,    49,    50,    50,    51,    52,
-      53,    54,    55,    55,    55,    55,    55,    55,    56,    56,
-      56,    56,    57,    57,    58,    59,    60,    61,    61,    61,
-      61,    62,    63,    64,    65,    66,    66,    66,    66,    67,
-      68,    69,    70,    71,    72,    72,    72,    72,    73,    73,
-      73,    74,    74,    75,    75,    76,    76,    76,    77,    77,
-      78,    78,    79,    79,    79,    79,    79,    79,    79,    80,
-      80
+       0,    35,    36,    37,    37,    37,    37,    37,    37,    37,
+      37,    37,    38,    38,    38,    38,    38,    38,    38,    39,
+      39,    39,    39,    39,    39,    40,    40,    41,    42,    43,
+      44,    45,    45,    45,    45,    45,    45,    45,    46,    46,
+      46,    46,    46,    47,    48,    48,    49,    49,    50,    51,
+      52,    53,    54,    54,    54,    54,    54,    54,    55,    55,
+      55,    55,    56,    56,    57,    58,    59,    60,    60,    60,
+      60,    61,    62,    63,    64,    65,    65,    65,    65,    66,
+      67,    68,    69,    70,    71,    71,    71,    71,    72,    72,
+      73,    73,    74,    74,    75,    75,    75,    76,    76,    77,
+      77,    78,    78,    78,    78,    78,    78,    78,    79,    79
 };
 
 /* YYR2[YYN] -- Number of symbols composing right hand side of rule YYN.  */
-static const unsigned char yyr2[] =
+static const yytype_uint8 yyr2[] =
 {
        0,     2,     1,     0,     2,     2,     2,     4,     2,     4,
        4,     3,     1,     1,     1,     1,     1,     1,     1,     1,
@@ -565,81 +635,78 @@ static const unsigned char yyr2[] =
        2,     4,     0,     2,     3,     1,     3,     0,     2,     2,
        2,     3,     2,     1,     3,     0,     2,     2,     2,     3,
        3,     2,     2,     2,     0,     2,     2,     2,     4,     3,
-       3,     0,     2,     1,     1,     2,     2,     2,     1,     2,
-       0,     2,     1,     3,     3,     3,     2,     3,     3,     1,
-       1
+       0,     2,     1,     1,     2,     2,     2,     1,     2,     0,
+       2,     1,     3,     3,     3,     2,     3,     3,     1,     1
 };
 
 /* YYDEFACT[STATE-NAME] -- Default rule to reduce with in state
    STATE-NUM when YYTABLE doesn't specify something else to do.  Zero
    means the default is an error.  */
-static const unsigned char yydefact[] =
+static const yytype_uint8 yydefact[] =
 {
        3,     0,     0,     1,     0,     0,     0,     0,     0,     0,
        0,     0,     0,     0,     0,     0,    12,    16,    13,    14,
       18,    15,    17,     0,    19,     0,     4,    31,    22,    31,
       23,    52,    62,     5,    67,    20,    84,    75,     6,    24,
-      84,    21,     8,    11,    93,    94,     0,     0,    95,     0,
-      48,    96,     0,     0,     0,   109,   110,     0,     0,     0,
-     102,    97,     0,     0,     0,     0,     0,     0,     0,     0,
-       0,     0,    98,     7,    71,    79,    80,    27,    29,     0,
-     106,     0,     0,    64,     0,     0,     9,    10,     0,     0,
-       0,     0,     0,    91,     0,     0,     0,    44,     0,    37,
-      36,    32,    33,     0,    35,    34,     0,     0,    91,     0,
-      56,    57,    53,    55,    54,    63,    51,    50,    68,    70,
-      66,    69,    65,    86,    87,    85,    76,    78,    74,    77,
-      73,    99,   105,   107,   108,   104,   103,    26,    82,     0,
-       0,     0,   100,     0,   100,   100,   100,     0,     0,     0,
-      83,    60,   100,     0,   100,     0,    89,    90,     0,     0,
-      38,    92,     0,     0,   100,    46,    43,    25,     0,    59,
-       0,    88,   101,    39,    40,    41,     0,     0,    45,    58,
-      61,    42,    47
+      84,    21,     8,    11,    92,    93,     0,     0,    94,     0,
+      48,    95,     0,     0,     0,   108,   109,     0,     0,     0,
+     101,    96,     0,     0,     0,     0,     0,     0,     0,     0,
+       0,     0,    97,     7,    71,    79,    80,    27,    29,     0,
+     105,     0,     0,    64,     0,     0,     9,    10,     0,     0,
+       0,     0,    90,     0,     0,     0,    44,     0,    37,    36,
+      32,    33,     0,    35,    34,     0,     0,    90,     0,    56,
+      57,    53,    55,    54,    63,    51,    50,    68,    70,    66,
+      69,    65,    86,    87,    85,    76,    78,    74,    77,    73,
+      98,   104,   106,   107,   103,   102,    26,    82,     0,     0,
+      99,     0,    99,    99,    99,     0,     0,     0,    83,    60,
+      99,     0,    99,     0,    89,     0,     0,    38,    91,     0,
+       0,    99,    46,    43,    25,     0,    59,     0,    88,   100,
+      39,    40,    41,     0,     0,    45,    58,    61,    42,    47
 };
 
-/* YYDEFGOTO[NTERM-NUM]. */
-static const short int yydefgoto[] =
+/* YYDEFGOTO[NTERM-NUM].  */
+static const yytype_int16 yydefgoto[] =
 {
-      -1,     1,     2,    25,    26,   100,    27,    28,    29,    30,
-      64,   101,   102,   148,   178,    31,    32,   116,    33,    66,
-     112,    67,    34,   120,    35,    68,    36,    37,   128,    38,
-      70,    39,    40,    41,   103,   104,    69,   105,   143,   144,
-      42,    73,   159,    59,    60
+      -1,     1,     2,    25,    26,    99,    27,    28,    29,    30,
+      64,   100,   101,   146,   175,    31,    32,   115,    33,    66,
+     111,    67,    34,   119,    35,    68,    36,    37,   127,    38,
+      70,    39,    40,    41,   102,   103,    69,   104,   141,   142,
+      42,    73,   156,    59,    60
 };
 
 /* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
    STATE-NUM.  */
-#define YYPACT_NINF -135
-static const short int yypact[] =
+#define YYPACT_NINF -119
+static const yytype_int16 yypact[] =
 {
-    -135,     2,   170,  -135,   -14,    56,    56,    -8,    56,    24,
-      67,    56,     7,    14,    62,    97,  -135,  -135,  -135,  -135,
-    -135,  -135,  -135,   156,  -135,   166,  -135,  -135,  -135,  -135,
-    -135,  -135,  -135,  -135,  -135,  -135,  -135,  -135,  -135,  -135,
-    -135,  -135,  -135,  -135,  -135,  -135,   138,   151,  -135,   152,
-    -135,  -135,   163,   167,   176,  -135,  -135,    62,    62,   185,
-     -19,  -135,   188,   190,    42,   103,   194,    85,    70,   222,
-      70,   132,  -135,   191,  -135,  -135,  -135,  -135,  -135,   127,
-    -135,    62,    62,   191,   104,   104,  -135,  -135,   193,   203,
-       9,    62,    56,    56,    62,   161,   104,  -135,   196,  -135,
-    -135,  -135,  -135,   233,  -135,  -135,   204,    56,    56,   221,
-    -135,  -135,  -135,  -135,  -135,  -135,  -135,  -135,  -135,  -135,
-    -135,  -135,  -135,  -135,  -135,  -135,  -135,  -135,  -135,  -135,
-    -135,  -135,  -135,   219,  -135,  -135,  -135,  -135,  -135,    62,
-     209,   212,   240,   224,   240,    -1,   240,   104,    41,   225,
-    -135,  -135,   240,   226,   240,   218,  -135,  -135,    62,   227,
-    -135,  -135,   228,   229,   240,   230,  -135,  -135,   231,  -135,
-     232,  -135,   112,  -135,  -135,  -135,   234,    56,  -135,  -135,
-    -135,  -135,  -135
+    -119,     2,   131,  -119,     6,    62,    62,    24,    62,    37,
+      47,    62,    80,    91,   186,   100,  -119,  -119,  -119,  -119,
+    -119,  -119,  -119,   179,  -119,   189,  -119,  -119,  -119,  -119,
+    -119,  -119,  -119,  -119,  -119,  -119,  -119,  -119,  -119,  -119,
+    -119,  -119,  -119,  -119,  -119,  -119,   163,   187,  -119,   188,
+    -119,  -119,   201,   202,   203,  -119,  -119,   186,   186,   191,
+     -10,  -119,   204,   205,    41,   103,    64,   149,     5,   194,
+       5,   167,  -119,   206,  -119,  -119,  -119,  -119,  -119,   134,
+    -119,   186,   186,   206,   118,   118,  -119,  -119,   207,   208,
+      66,    62,    62,   186,   214,   118,  -119,   239,  -119,  -119,
+    -119,  -119,   228,  -119,  -119,   212,    62,    62,   218,  -119,
+    -119,  -119,  -119,  -119,  -119,  -119,  -119,  -119,  -119,  -119,
+    -119,  -119,  -119,  -119,  -119,  -119,  -119,  -119,  -119,  -119,
+    -119,  -119,   213,  -119,  -119,  -119,  -119,  -119,   186,   195,
+     230,   216,   230,     7,   230,   118,    -3,   217,  -119,  -119,
+     230,   219,   230,   198,  -119,   186,   220,  -119,  -119,   221,
+     222,   230,   215,  -119,  -119,   223,  -119,   224,  -119,   175,
+    -119,  -119,  -119,   225,    62,  -119,  -119,  -119,  -119,  -119
 };
 
 /* YYPGOTO[NTERM-NUM].  */
-static const short int yypgoto[] =
+static const yytype_int16 yypgoto[] =
 {
-    -135,  -135,  -135,  -135,    94,   -45,  -135,  -135,  -135,  -135,
-     237,  -135,  -135,  -135,  -135,  -135,  -135,  -135,   -54,  -135,
-    -135,  -135,  -135,  -135,  -135,  -135,  -135,  -135,  -135,     1,
-    -135,  -135,  -135,  -135,  -135,   195,   235,   -44,   159,    -5,
-      98,   210,  -134,   -53,   -77
+    -119,  -119,  -119,  -119,   -37,    27,  -119,  -119,  -119,  -119,
+     227,  -119,  -119,  -119,  -119,  -119,  -119,  -119,    29,  -119,
+    -119,  -119,  -119,  -119,  -119,  -119,  -119,  -119,  -119,    59,
+    -119,  -119,  -119,  -119,  -119,   192,   226,   125,   150,    -5,
+     146,   200,  -118,   -53,   -77
 };
 
 /* YYTABLE[YYPACT[STATE-NUM]].  What to do in state STATE-NUM.  If
@@ -647,93 +714,90 @@ static const short int yypgoto[] =
    number is the opposite.  If zero, do what YYDEFACT says.
    If YYTABLE_NINF, syntax error.  */
 #define YYTABLE_NINF -82
-static const short int yytable[] =
+static const yytype_int16 yytable[] =
 {
-      46,    47,     3,    49,    79,    80,    52,   135,   136,    84,
-     161,   162,   163,   158,   119,    85,   127,    43,   168,   147,
-     170,   111,   114,    48,   124,   125,   124,   125,   133,   134,
-     176,    81,    82,    53,   139,    55,    56,   140,   141,    57,
-      54,   145,   -28,    88,    58,   -28,   -28,   -28,   -28,   -28,
-     -28,   -28,   -28,   -28,    89,    50,   -28,   -28,    90,    91,
-     -28,    92,    93,    94,    95,    96,    97,   165,    98,   121,
-     164,   129,   166,    99,     6,     7,     8,     9,    10,    11,
-      12,    13,    44,    45,    14,    15,   155,   142,    55,    56,
-       7,     8,    57,    10,    11,    12,    13,    58,    51,    14,
-      15,    24,   152,   -30,    88,   172,   -30,   -30,   -30,   -30,
-     -30,   -30,   -30,   -30,   -30,    89,    24,   -30,   -30,    90,
-      91,   -30,    92,    93,    94,    95,    96,    97,    61,    98,
-      55,    56,   -81,    88,    99,   -81,   -81,   -81,   -81,   -81,
-     -81,   -81,   -81,   -81,    81,    82,   -81,   -81,    90,    91,
-     -81,   -81,   -81,   -81,   -81,   -81,   132,    62,    98,    81,
-      82,   115,   118,   123,   126,   117,   122,    63,   130,    72,
-      -2,     4,   182,     5,     6,     7,     8,     9,    10,    11,
-      12,    13,    74,    75,    14,    15,    16,   146,    17,    18,
-      19,    20,    21,    22,    76,    88,    23,   149,    77,   -49,
-     -49,    24,   -49,   -49,   -49,   -49,    89,    78,   -49,   -49,
-      90,    91,   106,   107,   108,   109,    72,    81,    82,    86,
-      98,    87,   131,    88,   137,   110,   -72,   -72,   -72,   -72,
-     -72,   -72,   -72,   -72,   138,   151,   -72,   -72,    90,    91,
-     156,    81,    82,   157,    81,    82,   150,   154,    98,   171,
-      81,    82,    82,   123,   158,   160,   167,   169,   173,   174,
-     175,   113,   179,   180,   177,   181,    65,   153,     0,    83,
-       0,     0,     0,     0,     0,    71
+      46,    47,     3,    49,    79,    80,    52,   134,   135,     6,
+       7,     8,     9,    10,    11,    12,    13,    84,   145,    14,
+      15,   155,   162,    85,   158,   159,   160,   163,   132,   133,
+     114,   117,   165,   125,   167,    24,    43,   139,    81,    82,
+     143,   -28,    88,   173,   -28,   -28,   -28,   -28,   -28,   -28,
+     -28,   -28,   -28,    89,    48,   -28,   -28,    90,   -28,    91,
+      92,    93,    94,    95,    96,    88,    97,    50,   161,   -49,
+     -49,    98,   -49,   -49,   -49,   -49,    89,    51,   -49,   -49,
+      90,   105,   106,   107,   108,   153,   140,    44,    45,    97,
+     138,    55,    56,   110,   109,    57,   123,   118,   123,   126,
+      58,   150,   169,   -30,    88,    53,   -30,   -30,   -30,   -30,
+     -30,   -30,   -30,   -30,   -30,    89,    54,   -30,   -30,    90,
+     -30,    91,    92,    93,    94,    95,    96,   120,    97,   128,
+      61,    -2,     4,    98,     5,     6,     7,     8,     9,    10,
+      11,    12,    13,    55,    56,    14,    15,    16,    17,    18,
+      19,    20,    21,    22,     7,     8,    23,    10,    11,    12,
+      13,    24,   131,    14,    15,    81,    82,   -81,    88,   179,
+     -81,   -81,   -81,   -81,   -81,   -81,   -81,   -81,   -81,    24,
+      62,   -81,   -81,    90,   -81,   -81,   -81,   -81,   -81,   -81,
+      63,   113,    97,    72,   124,    88,   124,   122,   -72,   -72,
+     -72,   -72,   -72,   -72,   -72,   -72,    81,    82,   -72,   -72,
+      90,    55,    56,   116,   121,    57,   129,    74,    75,    97,
+      58,    72,    81,    82,   122,   154,    81,    82,   168,    81,
+      82,    76,    77,    78,    86,    87,   130,   136,   137,   144,
+     147,   148,   149,   152,   155,    82,   157,   164,   174,   166,
+     170,   171,   172,   176,   177,   178,    65,   151,   112,    83,
+       0,     0,     0,     0,     0,     0,    71
 };
 
-static const short int yycheck[] =
+static const yytype_int16 yycheck[] =
 {
-       5,     6,     0,     8,    57,    58,    11,    84,    85,    28,
-     144,   145,   146,    14,    68,    34,    70,    31,   152,    96,
-     154,    66,    66,    31,    69,    69,    71,    71,    81,    82,
-     164,    32,    33,    26,    25,    26,    27,    90,    91,    30,
-      26,    94,     0,     1,    35,     3,     4,     5,     6,     7,
-       8,     9,    10,    11,    12,    31,    14,    15,    16,    17,
-      18,    19,    20,    21,    22,    23,    24,    26,    26,    68,
-     147,    70,    31,    31,     4,     5,     6,     7,     8,     9,
-      10,    11,    26,    27,    14,    15,   139,    92,    26,    27,
-       5,     6,    30,     8,     9,    10,    11,    35,    31,    14,
-      15,    31,   107,     0,     1,   158,     3,     4,     5,     6,
-       7,     8,     9,    10,    11,    12,    31,    14,    15,    16,
-      17,    18,    19,    20,    21,    22,    23,    24,    31,    26,
-      26,    27,     0,     1,    31,     3,     4,     5,     6,     7,
-       8,     9,    10,    11,    32,    33,    14,    15,    16,    17,
-      18,    19,    20,    21,    22,    23,    29,     1,    26,    32,
-      33,    67,    68,    31,    70,    67,    68,     1,    70,    31,
-       0,     1,   177,     3,     4,     5,     6,     7,     8,     9,
-      10,    11,    31,    31,    14,    15,    16,    26,    18,    19,
-      20,    21,    22,    23,    31,     1,    26,     1,    31,     5,
-       6,    31,     8,     9,    10,    11,    12,    31,    14,    15,
-      16,    17,    18,    19,    20,    21,    31,    32,    33,    31,
-      26,    31,    31,     1,    31,    31,     4,     5,     6,     7,
-       8,     9,    10,    11,    31,    31,    14,    15,    16,    17,
-      31,    32,    33,    31,    32,    33,    13,    26,    26,    31,
-      32,    33,    33,    31,    14,    31,    31,    31,    31,    31,
-      31,    66,    31,    31,    34,    31,    29,   108,    -1,    59,
-      -1,    -1,    -1,    -1,    -1,    40
+       5,     6,     0,     8,    57,    58,    11,    84,    85,     4,
+       5,     6,     7,     8,     9,    10,    11,    27,    95,    14,
+      15,    14,    25,    33,   142,   143,   144,    30,    81,    82,
+      67,    68,   150,    70,   152,    30,    30,    90,    31,    32,
+      93,     0,     1,   161,     3,     4,     5,     6,     7,     8,
+       9,    10,    11,    12,    30,    14,    15,    16,    17,    18,
+      19,    20,    21,    22,    23,     1,    25,    30,   145,     5,
+       6,    30,     8,     9,    10,    11,    12,    30,    14,    15,
+      16,    17,    18,    19,    20,   138,    91,    25,    26,    25,
+      24,    25,    26,    66,    30,    29,    69,    68,    71,    70,
+      34,   106,   155,     0,     1,    25,     3,     4,     5,     6,
+       7,     8,     9,    10,    11,    12,    25,    14,    15,    16,
+      17,    18,    19,    20,    21,    22,    23,    68,    25,    70,
+      30,     0,     1,    30,     3,     4,     5,     6,     7,     8,
+       9,    10,    11,    25,    26,    14,    15,    16,    17,    18,
+      19,    20,    21,    22,     5,     6,    25,     8,     9,    10,
+      11,    30,    28,    14,    15,    31,    32,     0,     1,   174,
+       3,     4,     5,     6,     7,     8,     9,    10,    11,    30,
+       1,    14,    15,    16,    17,    18,    19,    20,    21,    22,
+       1,    66,    25,    30,    69,     1,    71,    30,     4,     5,
+       6,     7,     8,     9,    10,    11,    31,    32,    14,    15,
+      16,    25,    26,    67,    68,    29,    70,    30,    30,    25,
+      34,    30,    31,    32,    30,    30,    31,    32,    30,    31,
+      32,    30,    30,    30,    30,    30,    30,    30,    30,    25,
+       1,    13,    30,    25,    14,    32,    30,    30,    33,    30,
+      30,    30,    30,    30,    30,    30,    29,   107,    66,    59,
+      -1,    -1,    -1,    -1,    -1,    -1,    40
 };
 
 /* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
    symbol of state STATE-NUM.  */
-static const unsigned char yystos[] =
+static const yytype_uint8 yystos[] =
 {
-       0,    37,    38,     0,     1,     3,     4,     5,     6,     7,
-       8,     9,    10,    11,    14,    15,    16,    18,    19,    20,
-      21,    22,    23,    26,    31,    39,    40,    42,    43,    44,
-      45,    51,    52,    54,    58,    60,    62,    63,    65,    67,
-      68,    69,    76,    31,    26,    27,    75,    75,    31,    75,
-      31,    31,    75,    26,    26,    26,    27,    30,    35,    79,
-      80,    31,     1,     1,    46,    46,    55,    57,    61,    72,
-      66,    72,    31,    77,    31,    31,    31,    31,    31,    79,
-      79,    32,    33,    77,    28,    34,    31,    31,     1,    12,
-      16,    17,    19,    20,    21,    22,    23,    24,    26,    31,
-      41,    47,    48,    70,    71,    73,    18,    19,    20,    21,
-      31,    41,    56,    71,    73,    40,    53,    76,    40,    54,
-      59,    65,    76,    31,    41,    73,    40,    54,    64,    65,
-      76,    31,    29,    79,    79,    80,    80,    31,    31,    25,
-      79,    79,    75,    74,    75,    79,    26,    80,    49,     1,
-      13,    31,    75,    74,    26,    79,    31,    31,    14,    78,
-      31,    78,    78,    78,    80,    26,    31,    31,    78,    31,
-      78,    31,    79,    31,    31,    31,    78,    34,    50,    31,
-      31,    31,    75
+       0,    36,    37,     0,     1,     3,     4,     5,     6,     7,
+       8,     9,    10,    11,    14,    15,    16,    17,    18,    19,
+      20,    21,    22,    25,    30,    38,    39,    41,    42,    43,
+      44,    50,    51,    53,    57,    59,    61,    62,    64,    66,
+      67,    68,    75,    30,    25,    26,    74,    74,    30,    74,
+      30,    30,    74,    25,    25,    25,    26,    29,    34,    78,
+      79,    30,     1,     1,    45,    45,    54,    56,    60,    71,
+      65,    71,    30,    76,    30,    30,    30,    30,    30,    78,
+      78,    31,    32,    76,    27,    33,    30,    30,     1,    12,
+      16,    18,    19,    20,    21,    22,    23,    25,    30,    40,
+      46,    47,    69,    70,    72,    17,    18,    19,    20,    30,
+      40,    55,    70,    72,    39,    52,    75,    39,    53,    58,
+      64,    75,    30,    40,    72,    39,    53,    63,    64,    75,
+      30,    28,    78,    78,    79,    79,    30,    30,    24,    78,
+      74,    73,    74,    78,    25,    79,    48,     1,    13,    30,
+      74,    73,    25,    78,    30,    14,    77,    30,    77,    77,
+      77,    79,    25,    30,    30,    77,    30,    77,    30,    78,
+      30,    30,    30,    77,    33,    49,    30,    30,    30,    74
 };
 
 #define yyerrok		(yyerrstatus = 0)
@@ -761,7 +825,7 @@ do								\
       yychar = (Token);						\
       yylval = (Value);						\
       yytoken = YYTRANSLATE (yychar);				\
-      YYPOPSTACK;						\
+      YYPOPSTACK (1);						\
       goto yybackup;						\
     }								\
   else								\
@@ -769,7 +833,7 @@ do								\
       yyerror (YY_("syntax error: cannot back up")); \
       YYERROR;							\
     }								\
-while (0)
+while (YYID (0))
 
 
 #define YYTERROR	1
@@ -784,7 +848,7 @@ while (0)
 #ifndef YYLLOC_DEFAULT
 # define YYLLOC_DEFAULT(Current, Rhs, N)				\
     do									\
-      if (N)								\
+      if (YYID (N))                                                    \
 	{								\
 	  (Current).first_line   = YYRHSLOC (Rhs, 1).first_line;	\
 	  (Current).first_column = YYRHSLOC (Rhs, 1).first_column;	\
@@ -798,7 +862,7 @@ while (0)
 	  (Current).first_column = (Current).last_column =		\
 	    YYRHSLOC (Rhs, 0).last_column;				\
 	}								\
-    while (0)
+    while (YYID (0))
 #endif
 
 
@@ -810,8 +874,8 @@ while (0)
 # if YYLTYPE_IS_TRIVIAL
 #  define YY_LOCATION_PRINT(File, Loc)			\
      fprintf (File, "%d.%d-%d.%d",			\
-              (Loc).first_line, (Loc).first_column,	\
-              (Loc).last_line,  (Loc).last_column)
+	      (Loc).first_line, (Loc).first_column,	\
+	      (Loc).last_line,  (Loc).last_column)
 # else
 #  define YY_LOCATION_PRINT(File, Loc) ((void) 0)
 # endif
@@ -838,36 +902,96 @@ while (0)
 do {						\
   if (yydebug)					\
     YYFPRINTF Args;				\
-} while (0)
+} while (YYID (0))
+
+# define YY_SYMBOL_PRINT(Title, Type, Value, Location)			  \
+do {									  \
+  if (yydebug)								  \
+    {									  \
+      YYFPRINTF (stderr, "%s ", Title);					  \
+      yy_symbol_print (stderr,						  \
+		  Type, Value); \
+      YYFPRINTF (stderr, "\n");						  \
+    }									  \
+} while (YYID (0))
 
-# define YY_SYMBOL_PRINT(Title, Type, Value, Location)		\
-do {								\
-  if (yydebug)							\
-    {								\
-      YYFPRINTF (stderr, "%s ", Title);				\
-      yysymprint (stderr,					\
-                  Type, Value);	\
-      YYFPRINTF (stderr, "\n");					\
-    }								\
-} while (0)
+
+/*--------------------------------.
+| Print this symbol on YYOUTPUT.  |
+`--------------------------------*/
+
+/*ARGSUSED*/
+#if (defined __STDC__ || defined __C99__FUNC__ \
+     || defined __cplusplus || defined _MSC_VER)
+static void
+yy_symbol_value_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
+#else
+static void
+yy_symbol_value_print (yyoutput, yytype, yyvaluep)
+    FILE *yyoutput;
+    int yytype;
+    YYSTYPE const * const yyvaluep;
+#endif
+{
+  if (!yyvaluep)
+    return;
+# ifdef YYPRINT
+  if (yytype < YYNTOKENS)
+    YYPRINT (yyoutput, yytoknum[yytype], *yyvaluep);
+# else
+  YYUSE (yyoutput);
+# endif
+  switch (yytype)
+    {
+      default:
+	break;
+    }
+}
+
+
+/*--------------------------------.
+| Print this symbol on YYOUTPUT.  |
+`--------------------------------*/
+
+#if (defined __STDC__ || defined __C99__FUNC__ \
+     || defined __cplusplus || defined _MSC_VER)
+static void
+yy_symbol_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
+#else
+static void
+yy_symbol_print (yyoutput, yytype, yyvaluep)
+    FILE *yyoutput;
+    int yytype;
+    YYSTYPE const * const yyvaluep;
+#endif
+{
+  if (yytype < YYNTOKENS)
+    YYFPRINTF (yyoutput, "token %s (", yytname[yytype]);
+  else
+    YYFPRINTF (yyoutput, "nterm %s (", yytname[yytype]);
+
+  yy_symbol_value_print (yyoutput, yytype, yyvaluep);
+  YYFPRINTF (yyoutput, ")");
+}
 
 /*------------------------------------------------------------------.
 | yy_stack_print -- Print the state stack from its BOTTOM up to its |
 | TOP (included).                                                   |
 `------------------------------------------------------------------*/
 
-#if defined (__STDC__) || defined (__cplusplus)
+#if (defined __STDC__ || defined __C99__FUNC__ \
+     || defined __cplusplus || defined _MSC_VER)
 static void
-yy_stack_print (short int *bottom, short int *top)
+yy_stack_print (yytype_int16 *bottom, yytype_int16 *top)
 #else
 static void
 yy_stack_print (bottom, top)
-    short int *bottom;
-    short int *top;
+    yytype_int16 *bottom;
+    yytype_int16 *top;
 #endif
 {
   YYFPRINTF (stderr, "Stack now");
-  for (/* Nothing. */; bottom <= top; ++bottom)
+  for (; bottom <= top; ++bottom)
     YYFPRINTF (stderr, " %d", *bottom);
   YYFPRINTF (stderr, "\n");
 }
@@ -876,37 +1000,45 @@ yy_stack_print (bottom, top)
 do {								\
   if (yydebug)							\
     yy_stack_print ((Bottom), (Top));				\
-} while (0)
+} while (YYID (0))
 
 
 /*------------------------------------------------.
 | Report that the YYRULE is going to be reduced.  |
 `------------------------------------------------*/
 
-#if defined (__STDC__) || defined (__cplusplus)
+#if (defined __STDC__ || defined __C99__FUNC__ \
+     || defined __cplusplus || defined _MSC_VER)
 static void
-yy_reduce_print (int yyrule)
+yy_reduce_print (YYSTYPE *yyvsp, int yyrule)
 #else
 static void
-yy_reduce_print (yyrule)
+yy_reduce_print (yyvsp, yyrule)
+    YYSTYPE *yyvsp;
     int yyrule;
 #endif
 {
+  int yynrhs = yyr2[yyrule];
   int yyi;
   unsigned long int yylno = yyrline[yyrule];
-  YYFPRINTF (stderr, "Reducing stack by rule %d (line %lu), ",
-             yyrule - 1, yylno);
-  /* Print the symbols being reduced, and their result.  */
-  for (yyi = yyprhs[yyrule]; 0 <= yyrhs[yyi]; yyi++)
-    YYFPRINTF (stderr, "%s ", yytname[yyrhs[yyi]]);
-  YYFPRINTF (stderr, "-> %s\n", yytname[yyr1[yyrule]]);
+  YYFPRINTF (stderr, "Reducing stack by rule %d (line %lu):\n",
+	     yyrule - 1, yylno);
+  /* The symbols being reduced.  */
+  for (yyi = 0; yyi < yynrhs; yyi++)
+    {
+      fprintf (stderr, "   $%d = ", yyi + 1);
+      yy_symbol_print (stderr, yyrhs[yyprhs[yyrule] + yyi],
+		       &(yyvsp[(yyi + 1) - (yynrhs)])
+		       		       );
+      fprintf (stderr, "\n");
+    }
 }
 
 # define YY_REDUCE_PRINT(Rule)		\
 do {					\
   if (yydebug)				\
-    yy_reduce_print (Rule);		\
-} while (0)
+    yy_reduce_print (yyvsp, Rule); \
+} while (YYID (0))
 
 /* Nonzero means print parse trace.  It is left uninitialized so that
    multiple parsers can coexist.  */
@@ -940,42 +1072,44 @@ int yydebug;
 #if YYERROR_VERBOSE
 
 # ifndef yystrlen
-#  if defined (__GLIBC__) && defined (_STRING_H)
+#  if defined __GLIBC__ && defined _STRING_H
 #   define yystrlen strlen
 #  else
 /* Return the length of YYSTR.  */
+#if (defined __STDC__ || defined __C99__FUNC__ \
+     || defined __cplusplus || defined _MSC_VER)
 static YYSIZE_T
-#   if defined (__STDC__) || defined (__cplusplus)
 yystrlen (const char *yystr)
-#   else
+#else
+static YYSIZE_T
 yystrlen (yystr)
-     const char *yystr;
-#   endif
+    const char *yystr;
+#endif
 {
-  const char *yys = yystr;
-
-  while (*yys++ != '\0')
+  YYSIZE_T yylen;
+  for (yylen = 0; yystr[yylen]; yylen++)
     continue;
-
-  return yys - yystr - 1;
+  return yylen;
 }
 #  endif
 # endif
 
 # ifndef yystpcpy
-#  if defined (__GLIBC__) && defined (_STRING_H) && defined (_GNU_SOURCE)
+#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
 #   define yystpcpy stpcpy
 #  else
 /* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
    YYDEST.  */
+#if (defined __STDC__ || defined __C99__FUNC__ \
+     || defined __cplusplus || defined _MSC_VER)
 static char *
-#   if defined (__STDC__) || defined (__cplusplus)
 yystpcpy (char *yydest, const char *yysrc)
-#   else
+#else
+static char *
 yystpcpy (yydest, yysrc)
-     char *yydest;
-     const char *yysrc;
-#   endif
+    char *yydest;
+    const char *yysrc;
+#endif
 {
   char *yyd = yydest;
   const char *yys = yysrc;
@@ -1001,7 +1135,7 @@ yytnamerr (char *yyres, const char *yystr)
 {
   if (*yystr == '"')
     {
-      size_t yyn = 0;
+      YYSIZE_T yyn = 0;
       char const *yyp = yystr;
 
       for (;;)
@@ -1036,53 +1170,123 @@ yytnamerr (char *yyres, const char *yystr)
 }
 # endif
 
-#endif /* YYERROR_VERBOSE */
-
-
-
-#if YYDEBUG
-/*--------------------------------.
-| Print this symbol on YYOUTPUT.  |
-`--------------------------------*/
-
-#if defined (__STDC__) || defined (__cplusplus)
-static void
-yysymprint (FILE *yyoutput, int yytype, YYSTYPE *yyvaluep)
-#else
-static void
-yysymprint (yyoutput, yytype, yyvaluep)
-    FILE *yyoutput;
-    int yytype;
-    YYSTYPE *yyvaluep;
-#endif
+/* Copy into YYRESULT an error message about the unexpected token
+   YYCHAR while in state YYSTATE.  Return the number of bytes copied,
+   including the terminating null byte.  If YYRESULT is null, do not
+   copy anything; just return the number of bytes that would be
+   copied.  As a special case, return 0 if an ordinary "syntax error"
+   message will do.  Return YYSIZE_MAXIMUM if overflow occurs during
+   size calculation.  */
+static YYSIZE_T
+yysyntax_error (char *yyresult, int yystate, int yychar)
 {
-  /* Pacify ``unused variable'' warnings.  */
-  (void) yyvaluep;
+  int yyn = yypact[yystate];
 
-  if (yytype < YYNTOKENS)
-    YYFPRINTF (yyoutput, "token %s (", yytname[yytype]);
+  if (! (YYPACT_NINF < yyn && yyn <= YYLAST))
+    return 0;
   else
-    YYFPRINTF (yyoutput, "nterm %s (", yytname[yytype]);
+    {
+      int yytype = YYTRANSLATE (yychar);
+      YYSIZE_T yysize0 = yytnamerr (0, yytname[yytype]);
+      YYSIZE_T yysize = yysize0;
+      YYSIZE_T yysize1;
+      int yysize_overflow = 0;
+      enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
+      char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
+      int yyx;
+
+# if 0
+      /* This is so xgettext sees the translatable formats that are
+	 constructed on the fly.  */
+      YY_("syntax error, unexpected %s");
+      YY_("syntax error, unexpected %s, expecting %s");
+      YY_("syntax error, unexpected %s, expecting %s or %s");
+      YY_("syntax error, unexpected %s, expecting %s or %s or %s");
+      YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s");
+# endif
+      char *yyfmt;
+      char const *yyf;
+      static char const yyunexpected[] = "syntax error, unexpected %s";
+      static char const yyexpecting[] = ", expecting %s";
+      static char const yyor[] = " or %s";
+      char yyformat[sizeof yyunexpected
+		    + sizeof yyexpecting - 1
+		    + ((YYERROR_VERBOSE_ARGS_MAXIMUM - 2)
+		       * (sizeof yyor - 1))];
+      char const *yyprefix = yyexpecting;
+
+      /* Start YYX at -YYN if negative to avoid negative indexes in
+	 YYCHECK.  */
+      int yyxbegin = yyn < 0 ? -yyn : 0;
+
+      /* Stay within bounds of both yycheck and yytname.  */
+      int yychecklim = YYLAST - yyn + 1;
+      int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
+      int yycount = 1;
+
+      yyarg[0] = yytname[yytype];
+      yyfmt = yystpcpy (yyformat, yyunexpected);
+
+      for (yyx = yyxbegin; yyx < yyxend; ++yyx)
+	if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR)
+	  {
+	    if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
+	      {
+		yycount = 1;
+		yysize = yysize0;
+		yyformat[sizeof yyunexpected - 1] = '\0';
+		break;
+	      }
+	    yyarg[yycount++] = yytname[yyx];
+	    yysize1 = yysize + yytnamerr (0, yytname[yyx]);
+	    yysize_overflow |= (yysize1 < yysize);
+	    yysize = yysize1;
+	    yyfmt = yystpcpy (yyfmt, yyprefix);
+	    yyprefix = yyor;
+	  }
 
+      yyf = YY_(yyformat);
+      yysize1 = yysize + yystrlen (yyf);
+      yysize_overflow |= (yysize1 < yysize);
+      yysize = yysize1;
 
-# ifdef YYPRINT
-  if (yytype < YYNTOKENS)
-    YYPRINT (yyoutput, yytoknum[yytype], *yyvaluep);
-# endif
-  switch (yytype)
-    {
-      default:
-        break;
+      if (yysize_overflow)
+	return YYSIZE_MAXIMUM;
+
+      if (yyresult)
+	{
+	  /* Avoid sprintf, as that infringes on the user's name space.
+	     Don't have undefined behavior even if the translation
+	     produced a string with the wrong number of "%s"s.  */
+	  char *yyp = yyresult;
+	  int yyi = 0;
+	  while ((*yyp = *yyf) != '\0')
+	    {
+	      if (*yyp == '%' && yyf[1] == 's' && yyi < yycount)
+		{
+		  yyp += yytnamerr (yyp, yyarg[yyi++]);
+		  yyf += 2;
+		}
+	      else
+		{
+		  yyp++;
+		  yyf++;
+		}
+	    }
+	}
+      return yysize;
     }
-  YYFPRINTF (yyoutput, ")");
 }
+#endif /* YYERROR_VERBOSE */
+
 
-#endif /* ! YYDEBUG */
 /*-----------------------------------------------.
 | Release the memory associated to this symbol.  |
 `-----------------------------------------------*/
 
-#if defined (__STDC__) || defined (__cplusplus)
+/*ARGSUSED*/
+#if (defined __STDC__ || defined __C99__FUNC__ \
+     || defined __cplusplus || defined _MSC_VER)
 static void
 yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep)
 #else
@@ -1093,8 +1297,7 @@ yydestruct (yymsg, yytype, yyvaluep)
     YYSTYPE *yyvaluep;
 #endif
 {
-  /* Pacify ``unused variable'' warnings.  */
-  (void) yyvaluep;
+  YYUSE (yyvaluep);
 
   if (!yymsg)
     yymsg = "Deleting";
@@ -1102,39 +1305,39 @@ yydestruct (yymsg, yytype, yyvaluep)
 
   switch (yytype)
     {
-      case 52: /* "choice_entry" */
+      case 51: /* "choice_entry" */
 
-        {
+	{
 	fprintf(stderr, "%s:%d: missing end statement for this entry\n",
 		(yyvaluep->menu)->file->name, (yyvaluep->menu)->lineno);
 	if (current_menu == (yyvaluep->menu))
 		menu_end_menu();
 };
 
-        break;
-      case 58: /* "if_entry" */
+	break;
+      case 57: /* "if_entry" */
 
-        {
+	{
 	fprintf(stderr, "%s:%d: missing end statement for this entry\n",
 		(yyvaluep->menu)->file->name, (yyvaluep->menu)->lineno);
 	if (current_menu == (yyvaluep->menu))
 		menu_end_menu();
 };
 
-        break;
-      case 63: /* "menu_entry" */
+	break;
+      case 62: /* "menu_entry" */
 
-        {
+	{
 	fprintf(stderr, "%s:%d: missing end statement for this entry\n",
 		(yyvaluep->menu)->file->name, (yyvaluep->menu)->lineno);
 	if (current_menu == (yyvaluep->menu))
 		menu_end_menu();
 };
 
-        break;
+	break;
 
       default:
-        break;
+	break;
     }
 }
 
@@ -1142,13 +1345,13 @@ yydestruct (yymsg, yytype, yyvaluep)
 /* Prevent warnings from -Wmissing-prototypes.  */
 
 #ifdef YYPARSE_PARAM
-# if defined (__STDC__) || defined (__cplusplus)
+#if defined __STDC__ || defined __cplusplus
 int yyparse (void *YYPARSE_PARAM);
-# else
+#else
 int yyparse ();
-# endif
+#endif
 #else /* ! YYPARSE_PARAM */
-#if defined (__STDC__) || defined (__cplusplus)
+#if defined __STDC__ || defined __cplusplus
 int yyparse (void);
 #else
 int yyparse ();
@@ -1173,20 +1376,24 @@ int yynerrs;
 `----------*/
 
 #ifdef YYPARSE_PARAM
-# if defined (__STDC__) || defined (__cplusplus)
-int yyparse (void *YYPARSE_PARAM)
-# else
-int yyparse (YYPARSE_PARAM)
-  void *YYPARSE_PARAM;
-# endif
+#if (defined __STDC__ || defined __C99__FUNC__ \
+     || defined __cplusplus || defined _MSC_VER)
+int
+yyparse (void *YYPARSE_PARAM)
+#else
+int
+yyparse (YYPARSE_PARAM)
+    void *YYPARSE_PARAM;
+#endif
 #else /* ! YYPARSE_PARAM */
-#if defined (__STDC__) || defined (__cplusplus)
+#if (defined __STDC__ || defined __C99__FUNC__ \
+     || defined __cplusplus || defined _MSC_VER)
 int
 yyparse (void)
 #else
 int
 yyparse ()
-    ;
+
 #endif
 #endif
 {
@@ -1198,6 +1405,12 @@ yyparse ()
   int yyerrstatus;
   /* Look-ahead token as an internal (translated) token number.  */
   int yytoken = 0;
+#if YYERROR_VERBOSE
+  /* Buffer for error messages, and its allocated size.  */
+  char yymsgbuf[128];
+  char *yymsg = yymsgbuf;
+  YYSIZE_T yymsg_alloc = sizeof yymsgbuf;
+#endif
 
   /* Three stacks and their tools:
      `yyss': related to states,
@@ -1208,9 +1421,9 @@ yyparse ()
      to reallocate them elsewhere.  */
 
   /* The state stack.  */
-  short int yyssa[YYINITDEPTH];
-  short int *yyss = yyssa;
-  short int *yyssp;
+  yytype_int16 yyssa[YYINITDEPTH];
+  yytype_int16 *yyss = yyssa;
+  yytype_int16 *yyssp;
 
   /* The semantic value stack.  */
   YYSTYPE yyvsa[YYINITDEPTH];
@@ -1219,7 +1432,7 @@ yyparse ()
 
 
 
-#define YYPOPSTACK   (yyvsp--, yyssp--)
+#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))
 
   YYSIZE_T yystacksize = YYINITDEPTH;
 
@@ -1228,9 +1441,9 @@ yyparse ()
   YYSTYPE yyval;
 
 
-  /* When reducing, the number of symbols on the RHS of the reduced
-     rule.  */
-  int yylen;
+  /* The number of symbols on the RHS of the reduced rule.
+     Keep to zero when no symbol should be popped.  */
+  int yylen = 0;
 
   YYDPRINTF ((stderr, "Starting parse\n"));
 
@@ -1254,8 +1467,7 @@ yyparse ()
 `------------------------------------------------------------*/
  yynewstate:
   /* In all cases, when you get here, the value and location stacks
-     have just been pushed. so pushing a state here evens the stacks.
-     */
+     have just been pushed.  So pushing a state here evens the stacks.  */
   yyssp++;
 
  yysetstate:
@@ -1268,11 +1480,11 @@ yyparse ()
 
 #ifdef yyoverflow
       {
-	/* Give user a chance to reallocate the stack. Use copies of
+	/* Give user a chance to reallocate the stack.  Use copies of
 	   these so that the &'s don't force the real ones into
 	   memory.  */
 	YYSTYPE *yyvs1 = yyvs;
-	short int *yyss1 = yyss;
+	yytype_int16 *yyss1 = yyss;
 
 
 	/* Each stack pointer address is followed by the size of the
@@ -1300,7 +1512,7 @@ yyparse ()
 	yystacksize = YYMAXDEPTH;
 
       {
-	short int *yyss1 = yyss;
+	yytype_int16 *yyss1 = yyss;
 	union yyalloc *yyptr =
 	  (union yyalloc *) YYSTACK_ALLOC (YYSTACK_BYTES (yystacksize));
 	if (! yyptr)
@@ -1335,12 +1547,10 @@ yyparse ()
 `-----------*/
 yybackup:
 
-/* Do appropriate processing given the current state.  */
-/* Read a look-ahead token if we need one and don't already have one.  */
-/* yyresume: */
+  /* Do appropriate processing given the current state.  Read a
+     look-ahead token if we need one and don't already have one.  */
 
   /* First try to decide what to do without reference to look-ahead token.  */
-
   yyn = yypact[yystate];
   if (yyn == YYPACT_NINF)
     goto yydefault;
@@ -1382,22 +1592,21 @@ yybackup:
   if (yyn == YYFINAL)
     YYACCEPT;
 
+  /* Count tokens shifted since error; after three, turn off error
+     status.  */
+  if (yyerrstatus)
+    yyerrstatus--;
+
   /* Shift the look-ahead token.  */
   YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);
 
-  /* Discard the token being shifted unless it is eof.  */
+  /* Discard the shifted token unless it is eof.  */
   if (yychar != YYEOF)
     yychar = YYEMPTY;
 
+  yystate = yyn;
   *++yyvsp = yylval;
 
-
-  /* Count tokens shifted since error; after three, turn off error
-     status.  */
-  if (yyerrstatus)
-    yyerrstatus--;
-
-  yystate = yyn;
   goto yynewstate;
 
 
@@ -1439,13 +1648,13 @@ yyreduce:
 
   case 9:
 
-    { zconf_error("unknown statement \"%s\"", (yyvsp[-2].string)); ;}
+    { zconf_error("unknown statement \"%s\"", (yyvsp[(2) - (4)].string)); ;}
     break;
 
   case 10:
 
     {
-	zconf_error("unexpected option \"%s\"", kconf_id_strings + (yyvsp[-2].id)->name);
+	zconf_error("unexpected option \"%s\"", kconf_id_strings + (yyvsp[(2) - (4)].id)->name);
 ;}
     break;
 
@@ -1456,7 +1665,7 @@ yyreduce:
 
   case 25:
 
-    { zconf_error("unknown option \"%s\"", (yyvsp[-2].string)); ;}
+    { zconf_error("unknown option \"%s\"", (yyvsp[(1) - (3)].string)); ;}
     break;
 
   case 26:
@@ -1467,10 +1676,10 @@ yyreduce:
   case 27:
 
     {
-	struct symbol *sym = sym_lookup((yyvsp[-1].string), 0);
+	struct symbol *sym = sym_lookup((yyvsp[(2) - (3)].string), 0);
 	sym->flags |= SYMBOL_OPTIONAL;
 	menu_add_entry(sym);
-	printd(DEBUG_PARSE, "%s:%d:config %s\n", zconf_curname(), zconf_lineno(), (yyvsp[-1].string));
+	printd(DEBUG_PARSE, "%s:%d:config %s\n", zconf_curname(), zconf_lineno(), (yyvsp[(2) - (3)].string));
 ;}
     break;
 
@@ -1485,10 +1694,10 @@ yyreduce:
   case 29:
 
     {
-	struct symbol *sym = sym_lookup((yyvsp[-1].string), 0);
+	struct symbol *sym = sym_lookup((yyvsp[(2) - (3)].string), 0);
 	sym->flags |= SYMBOL_OPTIONAL;
 	menu_add_entry(sym);
-	printd(DEBUG_PARSE, "%s:%d:menuconfig %s\n", zconf_curname(), zconf_lineno(), (yyvsp[-1].string));
+	printd(DEBUG_PARSE, "%s:%d:menuconfig %s\n", zconf_curname(), zconf_lineno(), (yyvsp[(2) - (3)].string));
 ;}
     break;
 
@@ -1507,17 +1716,17 @@ yyreduce:
   case 38:
 
     {
-	menu_set_type((yyvsp[-2].id)->stype);
+	menu_set_type((yyvsp[(1) - (3)].id)->stype);
 	printd(DEBUG_PARSE, "%s:%d:type(%u)\n",
 		zconf_curname(), zconf_lineno(),
-		(yyvsp[-2].id)->stype);
+		(yyvsp[(1) - (3)].id)->stype);
 ;}
     break;
 
   case 39:
 
     {
-	menu_add_prompt(P_PROMPT, (yyvsp[-2].string), (yyvsp[-1].expr));
+	menu_add_prompt(P_PROMPT, (yyvsp[(2) - (4)].string), (yyvsp[(3) - (4)].expr));
 	printd(DEBUG_PARSE, "%s:%d:prompt\n", zconf_curname(), zconf_lineno());
 ;}
     break;
@@ -1525,19 +1734,19 @@ yyreduce:
   case 40:
 
     {
-	menu_add_expr(P_DEFAULT, (yyvsp[-2].expr), (yyvsp[-1].expr));
-	if ((yyvsp[-3].id)->stype != S_UNKNOWN)
-		menu_set_type((yyvsp[-3].id)->stype);
+	menu_add_expr(P_DEFAULT, (yyvsp[(2) - (4)].expr), (yyvsp[(3) - (4)].expr));
+	if ((yyvsp[(1) - (4)].id)->stype != S_UNKNOWN)
+		menu_set_type((yyvsp[(1) - (4)].id)->stype);
 	printd(DEBUG_PARSE, "%s:%d:default(%u)\n",
 		zconf_curname(), zconf_lineno(),
-		(yyvsp[-3].id)->stype);
+		(yyvsp[(1) - (4)].id)->stype);
 ;}
     break;
 
   case 41:
 
     {
-	menu_add_symbol(P_SELECT, sym_lookup((yyvsp[-2].string), 0), (yyvsp[-1].expr));
+	menu_add_symbol(P_SELECT, sym_lookup((yyvsp[(2) - (4)].string), 0), (yyvsp[(3) - (4)].expr));
 	printd(DEBUG_PARSE, "%s:%d:select\n", zconf_curname(), zconf_lineno());
 ;}
     break;
@@ -1545,7 +1754,7 @@ yyreduce:
   case 42:
 
     {
-	menu_add_expr(P_RANGE, expr_alloc_comp(E_RANGE,(yyvsp[-3].symbol), (yyvsp[-2].symbol)), (yyvsp[-1].expr));
+	menu_add_expr(P_RANGE, expr_alloc_comp(E_RANGE,(yyvsp[(2) - (5)].symbol), (yyvsp[(3) - (5)].symbol)), (yyvsp[(4) - (5)].expr));
 	printd(DEBUG_PARSE, "%s:%d:range\n", zconf_curname(), zconf_lineno());
 ;}
     break;
@@ -1553,12 +1762,12 @@ yyreduce:
   case 45:
 
     {
-	struct kconf_id *id = kconf_id_lookup((yyvsp[-1].string), strlen((yyvsp[-1].string)));
+	struct kconf_id *id = kconf_id_lookup((yyvsp[(2) - (3)].string), strlen((yyvsp[(2) - (3)].string)));
 	if (id && id->flags & TF_OPTION)
-		menu_add_option(id->token, (yyvsp[0].string));
+		menu_add_option(id->token, (yyvsp[(3) - (3)].string));
 	else
-		zconfprint("warning: ignoring unknown option %s", (yyvsp[-1].string));
-	free((yyvsp[-1].string));
+		zconfprint("warning: ignoring unknown option %s", (yyvsp[(2) - (3)].string));
+	free((yyvsp[(2) - (3)].string));
 ;}
     break;
 
@@ -1569,7 +1778,7 @@ yyreduce:
 
   case 47:
 
-    { (yyval.string) = (yyvsp[0].string); ;}
+    { (yyval.string) = (yyvsp[(2) - (2)].string); ;}
     break;
 
   case 48:
@@ -1593,7 +1802,7 @@ yyreduce:
   case 50:
 
     {
-	if (zconf_endtoken((yyvsp[0].id), T_CHOICE, T_ENDCHOICE)) {
+	if (zconf_endtoken((yyvsp[(1) - (1)].id), T_CHOICE, T_ENDCHOICE)) {
 		menu_end_menu();
 		printd(DEBUG_PARSE, "%s:%d:endchoice\n", zconf_curname(), zconf_lineno());
 	}
@@ -1603,7 +1812,7 @@ yyreduce:
   case 58:
 
     {
-	menu_add_prompt(P_PROMPT, (yyvsp[-2].string), (yyvsp[-1].expr));
+	menu_add_prompt(P_PROMPT, (yyvsp[(2) - (4)].string), (yyvsp[(3) - (4)].expr));
 	printd(DEBUG_PARSE, "%s:%d:prompt\n", zconf_curname(), zconf_lineno());
 ;}
     break;
@@ -1611,11 +1820,11 @@ yyreduce:
   case 59:
 
     {
-	if ((yyvsp[-2].id)->stype == S_BOOLEAN || (yyvsp[-2].id)->stype == S_TRISTATE) {
-		menu_set_type((yyvsp[-2].id)->stype);
+	if ((yyvsp[(1) - (3)].id)->stype == S_BOOLEAN || (yyvsp[(1) - (3)].id)->stype == S_TRISTATE) {
+		menu_set_type((yyvsp[(1) - (3)].id)->stype);
 		printd(DEBUG_PARSE, "%s:%d:type(%u)\n",
 			zconf_curname(), zconf_lineno(),
-			(yyvsp[-2].id)->stype);
+			(yyvsp[(1) - (3)].id)->stype);
 	} else
 		YYERROR;
 ;}
@@ -1632,8 +1841,8 @@ yyreduce:
   case 61:
 
     {
-	if ((yyvsp[-3].id)->stype == S_UNKNOWN) {
-		menu_add_symbol(P_DEFAULT, sym_lookup((yyvsp[-2].string), 0), (yyvsp[-1].expr));
+	if ((yyvsp[(1) - (4)].id)->stype == S_UNKNOWN) {
+		menu_add_symbol(P_DEFAULT, sym_lookup((yyvsp[(2) - (4)].string), 0), (yyvsp[(3) - (4)].expr));
 		printd(DEBUG_PARSE, "%s:%d:default\n",
 			zconf_curname(), zconf_lineno());
 	} else
@@ -1646,7 +1855,7 @@ yyreduce:
     {
 	printd(DEBUG_PARSE, "%s:%d:if\n", zconf_curname(), zconf_lineno());
 	menu_add_entry(NULL);
-	menu_add_dep((yyvsp[-1].expr));
+	menu_add_dep((yyvsp[(2) - (3)].expr));
 	(yyval.menu) = menu_add_menu();
 ;}
     break;
@@ -1654,7 +1863,7 @@ yyreduce:
   case 65:
 
     {
-	if (zconf_endtoken((yyvsp[0].id), T_IF, T_ENDIF)) {
+	if (zconf_endtoken((yyvsp[(1) - (1)].id), T_IF, T_ENDIF)) {
 		menu_end_menu();
 		printd(DEBUG_PARSE, "%s:%d:endif\n", zconf_curname(), zconf_lineno());
 	}
@@ -1665,7 +1874,7 @@ yyreduce:
 
     {
 	menu_add_entry(NULL);
-	menu_add_prompt(P_MENU, (yyvsp[-1].string), NULL);
+	menu_add_prompt(P_MENU, (yyvsp[(2) - (3)].string), NULL);
 	printd(DEBUG_PARSE, "%s:%d:menu\n", zconf_curname(), zconf_lineno());
 ;}
     break;
@@ -1680,7 +1889,7 @@ yyreduce:
   case 73:
 
     {
-	if (zconf_endtoken((yyvsp[0].id), T_MENU, T_ENDMENU)) {
+	if (zconf_endtoken((yyvsp[(1) - (1)].id), T_MENU, T_ENDMENU)) {
 		menu_end_menu();
 		printd(DEBUG_PARSE, "%s:%d:endmenu\n", zconf_curname(), zconf_lineno());
 	}
@@ -1690,8 +1899,8 @@ yyreduce:
   case 79:
 
     {
-	printd(DEBUG_PARSE, "%s:%d:source %s\n", zconf_curname(), zconf_lineno(), (yyvsp[-1].string));
-	zconf_nextfile((yyvsp[-1].string));
+	printd(DEBUG_PARSE, "%s:%d:source %s\n", zconf_curname(), zconf_lineno(), (yyvsp[(2) - (3)].string));
+	zconf_nextfile((yyvsp[(2) - (3)].string));
 ;}
     break;
 
@@ -1699,7 +1908,7 @@ yyreduce:
 
     {
 	menu_add_entry(NULL);
-	menu_add_prompt(P_COMMENT, (yyvsp[-1].string), NULL);
+	menu_add_prompt(P_COMMENT, (yyvsp[(2) - (3)].string), NULL);
 	printd(DEBUG_PARSE, "%s:%d:comment\n", zconf_curname(), zconf_lineno());
 ;}
     break;
@@ -1722,14 +1931,14 @@ yyreduce:
   case 83:
 
     {
-	current_entry->sym->help = (yyvsp[0].string);
+	current_entry->sym->help = (yyvsp[(2) - (2)].string);
 ;}
     break;
 
   case 88:
 
     {
-	menu_add_dep((yyvsp[-1].expr));
+	menu_add_dep((yyvsp[(3) - (4)].expr));
 	printd(DEBUG_PARSE, "%s:%d:depends on\n", zconf_curname(), zconf_lineno());
 ;}
     break;
@@ -1737,107 +1946,97 @@ yyreduce:
   case 89:
 
     {
-	menu_add_dep((yyvsp[-1].expr));
+	menu_add_dep((yyvsp[(2) - (3)].expr));
 	printd(DEBUG_PARSE, "%s:%d:depends\n", zconf_curname(), zconf_lineno());
 ;}
     break;
 
-  case 90:
+  case 91:
 
     {
-	menu_add_dep((yyvsp[-1].expr));
-	printd(DEBUG_PARSE, "%s:%d:requires\n", zconf_curname(), zconf_lineno());
+	menu_add_prompt(P_PROMPT, (yyvsp[(1) - (2)].string), (yyvsp[(2) - (2)].expr));
 ;}
     break;
 
-  case 92:
+  case 94:
 
-    {
-	menu_add_prompt(P_PROMPT, (yyvsp[-1].string), (yyvsp[0].expr));
-;}
+    { (yyval.id) = (yyvsp[(1) - (2)].id); ;}
     break;
 
   case 95:
 
-    { (yyval.id) = (yyvsp[-1].id); ;}
+    { (yyval.id) = (yyvsp[(1) - (2)].id); ;}
     break;
 
   case 96:
 
-    { (yyval.id) = (yyvsp[-1].id); ;}
+    { (yyval.id) = (yyvsp[(1) - (2)].id); ;}
     break;
 
-  case 97:
+  case 99:
 
-    { (yyval.id) = (yyvsp[-1].id); ;}
+    { (yyval.expr) = NULL; ;}
     break;
 
   case 100:
 
-    { (yyval.expr) = NULL; ;}
+    { (yyval.expr) = (yyvsp[(2) - (2)].expr); ;}
     break;
 
   case 101:
 
-    { (yyval.expr) = (yyvsp[0].expr); ;}
+    { (yyval.expr) = expr_alloc_symbol((yyvsp[(1) - (1)].symbol)); ;}
     break;
 
   case 102:
 
-    { (yyval.expr) = expr_alloc_symbol((yyvsp[0].symbol)); ;}
+    { (yyval.expr) = expr_alloc_comp(E_EQUAL, (yyvsp[(1) - (3)].symbol), (yyvsp[(3) - (3)].symbol)); ;}
     break;
 
   case 103:
 
-    { (yyval.expr) = expr_alloc_comp(E_EQUAL, (yyvsp[-2].symbol), (yyvsp[0].symbol)); ;}
+    { (yyval.expr) = expr_alloc_comp(E_UNEQUAL, (yyvsp[(1) - (3)].symbol), (yyvsp[(3) - (3)].symbol)); ;}
     break;
 
   case 104:
 
-    { (yyval.expr) = expr_alloc_comp(E_UNEQUAL, (yyvsp[-2].symbol), (yyvsp[0].symbol)); ;}
+    { (yyval.expr) = (yyvsp[(2) - (3)].expr); ;}
     break;
 
   case 105:
 
-    { (yyval.expr) = (yyvsp[-1].expr); ;}
+    { (yyval.expr) = expr_alloc_one(E_NOT, (yyvsp[(2) - (2)].expr)); ;}
     break;
 
   case 106:
 
-    { (yyval.expr) = expr_alloc_one(E_NOT, (yyvsp[0].expr)); ;}
+    { (yyval.expr) = expr_alloc_two(E_OR, (yyvsp[(1) - (3)].expr), (yyvsp[(3) - (3)].expr)); ;}
     break;
 
   case 107:
 
-    { (yyval.expr) = expr_alloc_two(E_OR, (yyvsp[-2].expr), (yyvsp[0].expr)); ;}
+    { (yyval.expr) = expr_alloc_two(E_AND, (yyvsp[(1) - (3)].expr), (yyvsp[(3) - (3)].expr)); ;}
     break;
 
   case 108:
 
-    { (yyval.expr) = expr_alloc_two(E_AND, (yyvsp[-2].expr), (yyvsp[0].expr)); ;}
+    { (yyval.symbol) = sym_lookup((yyvsp[(1) - (1)].string), 0); free((yyvsp[(1) - (1)].string)); ;}
     break;
 
   case 109:
 
-    { (yyval.symbol) = sym_lookup((yyvsp[0].string), 0); free((yyvsp[0].string)); ;}
+    { (yyval.symbol) = sym_lookup((yyvsp[(1) - (1)].string), 1); free((yyvsp[(1) - (1)].string)); ;}
     break;
 
-  case 110:
-
-    { (yyval.symbol) = sym_lookup((yyvsp[0].string), 1); free((yyvsp[0].string)); ;}
-    break;
 
+/* Line 1267 of yacc.c.  */
 
       default: break;
     }
+  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);
 
-/* Line 1126 of yacc.c.  */
-
-
-  yyvsp -= yylen;
-  yyssp -= yylen;
-
-
+  YYPOPSTACK (yylen);
+  yylen = 0;
   YY_STACK_PRINT (yyss, yyssp);
 
   *++yyvsp = yyval;
@@ -1866,110 +2065,41 @@ yyerrlab:
   if (!yyerrstatus)
     {
       ++yynerrs;
-#if YYERROR_VERBOSE
-      yyn = yypact[yystate];
-
-      if (YYPACT_NINF < yyn && yyn < YYLAST)
-	{
-	  int yytype = YYTRANSLATE (yychar);
-	  YYSIZE_T yysize0 = yytnamerr (0, yytname[yytype]);
-	  YYSIZE_T yysize = yysize0;
-	  YYSIZE_T yysize1;
-	  int yysize_overflow = 0;
-	  char *yymsg = 0;
-#	  define YYERROR_VERBOSE_ARGS_MAXIMUM 5
-	  char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
-	  int yyx;
-
-#if 0
-	  /* This is so xgettext sees the translatable formats that are
-	     constructed on the fly.  */
-	  YY_("syntax error, unexpected %s");
-	  YY_("syntax error, unexpected %s, expecting %s");
-	  YY_("syntax error, unexpected %s, expecting %s or %s");
-	  YY_("syntax error, unexpected %s, expecting %s or %s or %s");
-	  YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s");
-#endif
-	  char *yyfmt;
-	  char const *yyf;
-	  static char const yyunexpected[] = "syntax error, unexpected %s";
-	  static char const yyexpecting[] = ", expecting %s";
-	  static char const yyor[] = " or %s";
-	  char yyformat[sizeof yyunexpected
-			+ sizeof yyexpecting - 1
-			+ ((YYERROR_VERBOSE_ARGS_MAXIMUM - 2)
-			   * (sizeof yyor - 1))];
-	  char const *yyprefix = yyexpecting;
-
-	  /* Start YYX at -YYN if negative to avoid negative indexes in
-	     YYCHECK.  */
-	  int yyxbegin = yyn < 0 ? -yyn : 0;
-
-	  /* Stay within bounds of both yycheck and yytname.  */
-	  int yychecklim = YYLAST - yyn;
-	  int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
-	  int yycount = 1;
-
-	  yyarg[0] = yytname[yytype];
-	  yyfmt = yystpcpy (yyformat, yyunexpected);
-
-	  for (yyx = yyxbegin; yyx < yyxend; ++yyx)
-	    if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR)
+#if ! YYERROR_VERBOSE
+      yyerror (YY_("syntax error"));
+#else
+      {
+	YYSIZE_T yysize = yysyntax_error (0, yystate, yychar);
+	if (yymsg_alloc < yysize && yymsg_alloc < YYSTACK_ALLOC_MAXIMUM)
+	  {
+	    YYSIZE_T yyalloc = 2 * yysize;
+	    if (! (yysize <= yyalloc && yyalloc <= YYSTACK_ALLOC_MAXIMUM))
+	      yyalloc = YYSTACK_ALLOC_MAXIMUM;
+	    if (yymsg != yymsgbuf)
+	      YYSTACK_FREE (yymsg);
+	    yymsg = (char *) YYSTACK_ALLOC (yyalloc);
+	    if (yymsg)
+	      yymsg_alloc = yyalloc;
+	    else
 	      {
-		if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
-		  {
-		    yycount = 1;
-		    yysize = yysize0;
-		    yyformat[sizeof yyunexpected - 1] = '\0';
-		    break;
-		  }
-		yyarg[yycount++] = yytname[yyx];
-		yysize1 = yysize + yytnamerr (0, yytname[yyx]);
-		yysize_overflow |= yysize1 < yysize;
-		yysize = yysize1;
-		yyfmt = yystpcpy (yyfmt, yyprefix);
-		yyprefix = yyor;
+		yymsg = yymsgbuf;
+		yymsg_alloc = sizeof yymsgbuf;
 	      }
+	  }
 
-	  yyf = YY_(yyformat);
-	  yysize1 = yysize + yystrlen (yyf);
-	  yysize_overflow |= yysize1 < yysize;
-	  yysize = yysize1;
-
-	  if (!yysize_overflow && yysize <= YYSTACK_ALLOC_MAXIMUM)
-	    yymsg = (char *) YYSTACK_ALLOC (yysize);
-	  if (yymsg)
-	    {
-	      /* Avoid sprintf, as that infringes on the user's name space.
-		 Don't have undefined behavior even if the translation
-		 produced a string with the wrong number of "%s"s.  */
-	      char *yyp = yymsg;
-	      int yyi = 0;
-	      while ((*yyp = *yyf))
-		{
-		  if (*yyp == '%' && yyf[1] == 's' && yyi < yycount)
-		    {
-		      yyp += yytnamerr (yyp, yyarg[yyi++]);
-		      yyf += 2;
-		    }
-		  else
-		    {
-		      yyp++;
-		      yyf++;
-		    }
-		}
-	      yyerror (yymsg);
-	      YYSTACK_FREE (yymsg);
-	    }
-	  else
-	    {
-	      yyerror (YY_("syntax error"));
+	if (0 < yysize && yysize <= yymsg_alloc)
+	  {
+	    (void) yysyntax_error (yymsg, yystate, yychar);
+	    yyerror (yymsg);
+	  }
+	else
+	  {
+	    yyerror (YY_("syntax error"));
+	    if (yysize != 0)
 	      goto yyexhaustedlab;
-	    }
-	}
-      else
-#endif /* YYERROR_VERBOSE */
-	yyerror (YY_("syntax error"));
+	  }
+      }
+#endif
     }
 
 
@@ -1980,14 +2110,15 @@ yyerrlab:
 	 error, discard it.  */
 
       if (yychar <= YYEOF)
-        {
+	{
 	  /* Return failure if at end of input.  */
 	  if (yychar == YYEOF)
 	    YYABORT;
-        }
+	}
       else
 	{
-	  yydestruct ("Error: discarding", yytoken, &yylval);
+	  yydestruct ("Error: discarding",
+		      yytoken, &yylval);
 	  yychar = YYEMPTY;
 	}
     }
@@ -2005,11 +2136,14 @@ yyerrorlab:
   /* Pacify compilers like GCC when the user code never invokes
      YYERROR and the label yyerrorlab therefore never appears in user
      code.  */
-  if (0)
+  if (/*CONSTCOND*/ 0)
      goto yyerrorlab;
 
-yyvsp -= yylen;
-  yyssp -= yylen;
+  /* Do not reclaim the symbols of the rule which action triggered
+     this YYERROR.  */
+  YYPOPSTACK (yylen);
+  yylen = 0;
+  YY_STACK_PRINT (yyss, yyssp);
   yystate = *yyssp;
   goto yyerrlab1;
 
@@ -2039,8 +2173,9 @@ yyerrlab1:
 	YYABORT;
 
 
-      yydestruct ("Error: popping", yystos[yystate], yyvsp);
-      YYPOPSTACK;
+      yydestruct ("Error: popping",
+		  yystos[yystate], yyvsp);
+      YYPOPSTACK (1);
       yystate = *yyssp;
       YY_STACK_PRINT (yyss, yyssp);
     }
@@ -2051,7 +2186,7 @@ yyerrlab1:
   *++yyvsp = yylval;
 
 
-  /* Shift the error token. */
+  /* Shift the error token.  */
   YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);
 
   yystate = yyn;
@@ -2086,17 +2221,26 @@ yyreturn:
   if (yychar != YYEOF && yychar != YYEMPTY)
      yydestruct ("Cleanup: discarding lookahead",
 		 yytoken, &yylval);
+  /* Do not reclaim the symbols of the rule which action triggered
+     this YYABORT or YYACCEPT.  */
+  YYPOPSTACK (yylen);
+  YY_STACK_PRINT (yyss, yyssp);
   while (yyssp != yyss)
     {
       yydestruct ("Cleanup: popping",
 		  yystos[*yyssp], yyvsp);
-      YYPOPSTACK;
+      YYPOPSTACK (1);
     }
 #ifndef yyoverflow
   if (yyss != yyssa)
     YYSTACK_FREE (yyss);
 #endif
-  return yyresult;
+#if YYERROR_VERBOSE
+  if (yymsg != yymsgbuf)
+    YYSTACK_FREE (yymsg);
+#endif
+  /* Make sure YYID is used.  */
+  return YYID (yyresult);
 }
 
 
@@ -2342,4 +2486,3 @@ void zconfdump(FILE *out)
 #include "symbol.c"
 #include "menu.c"
 
-
diff --git a/scripts/kconfig/zconf.y b/scripts/kconfig/zconf.y
index 04a5864..7387387 100644
--- a/scripts/kconfig/zconf.y
+++ b/scripts/kconfig/zconf.y
@@ -64,7 +64,6 @@ static struct menu *current_menu, *current_entry;
 %token <id>T_IF
 %token <id>T_ENDIF
 %token <id>T_DEPENDS
-%token <id>T_REQUIRES
 %token <id>T_OPTIONAL
 %token <id>T_PROMPT
 %token <id>T_TYPE
@@ -423,11 +422,6 @@ depends: T_DEPENDS T_ON expr T_EOL
 {
 	menu_add_dep($2);
 	printd(DEBUG_PARSE, "%s:%d:depends\n", zconf_curname(), zconf_lineno());
-}
-	| T_REQUIRES expr T_EOL
-{
-	menu_add_dep($2);
-	printd(DEBUG_PARSE, "%s:%d:requires\n", zconf_curname(), zconf_lineno());
 };
 
 /* prompt statement */
