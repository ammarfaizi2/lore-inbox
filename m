Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264411AbUBNA11 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 19:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267292AbUBNA11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 19:27:27 -0500
Received: from h80ad253b.async.vt.edu ([128.173.37.59]:49592 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S264411AbUBNA1L (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 19:27:11 -0500
Message-Id: <200402140027.i1E0R3kT008700@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: "J.A. Magallon" <jamagallon@able.es>
cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: strxxx and gcc-3.4 
In-reply-to: Your message of "Sat, 14 Feb 2004 00:40:28 +0100."
             <20040213234028.GA3765@werewolf.able.es> 
From: Valdis.Kletnieks@vt.edu
References: <20040213234028.GA3765@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 13 Feb 2004 19:27:02 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Feb 2004 00:40:28 +0100, "J.A. Magallon" <jamagallon@able.es>  said:

> So at least the common interesting things are
>  `memcmp', `memcpy', `memset'
>  `strcat', `strchr', `strcmp', `strcpy', `strcspn', `strlen',
>  `strncat', `strncmp', `strncpy', `strpbrk', `strrchr', `strspn', `strstr', 
>  `sprintf', `snprintf', `sscanf', `vsprintf'
> 
> Preferences ?

How you feel about this?  EXPORT_SYMBOL() added.  Also, the whole
thing with #ifdef/#undef/#endif is needed, otherwise you end up doing
the EXPORT_SYMBOL on __builtin_foo instead of foo.

lib/vsprintf.c could probably use the same treatment....

--- linux-2.6.3-rc2-mm1/lib/string.c.orig	2004-02-12 14:18:28.000000000 -0500
+++ linux-2.6.3-rc2-mm1/lib/string.c	2004-02-13 19:22:18.093457913 -0500
@@ -27,6 +27,9 @@
 #include <linux/module.h>
 
 #ifndef __HAVE_ARCH_STRNICMP
+#ifdef strnicmp
+#undef strnicmp
+#endif
 /**
  * strnicmp - Case insensitive, length-limited string comparison
  * @s1: One string
@@ -62,6 +65,9 @@
 #endif
 
 #ifndef __HAVE_ARCH_STRCPY
+#ifdef strcpy
+#undef strcpy
+#endif
 /**
  * strcpy - Copy a %NUL terminated string
  * @dest: Where to copy the string to
@@ -75,9 +81,13 @@
 		/* nothing */;
 	return tmp;
 }
+EXPORT_SYMBOL(strcpy);
 #endif
 
 #ifndef __HAVE_ARCH_STRNCPY
+#ifdef strncpy
+#undef strncpy
+#endif
 /**
  * strncpy - Copy a length-limited, %NUL-terminated string
  * @dest: Where to copy the string to
@@ -98,9 +108,13 @@
 	}
 	return dest;
 }
+EXPORT_SYMBOL(strncpy);
 #endif
 
 #ifndef __HAVE_ARCH_STRLCPY
+#ifdef strlcpy
+#undef strlcpy
+#endif
 /**
  * strlcpy - Copy a %NUL terminated string into a sized buffer
  * @dest: Where to copy the string to
@@ -127,6 +141,9 @@
 #endif
 
 #ifndef __HAVE_ARCH_STRCAT
+#ifdef strcat
+#undef strcat
+#endif
 /**
  * strcat - Append one %NUL-terminated string to another
  * @dest: The string to be appended to
@@ -143,9 +160,13 @@
 
 	return tmp;
 }
+EXPORT_SYMBOL(strcat);
 #endif
 
 #ifndef __HAVE_ARCH_STRNCAT
+#ifdef strncat
+#undef strncat
+#endif
 /**
  * strncat - Append a length-limited, %NUL-terminated string to another
  * @dest: The string to be appended to
@@ -172,9 +193,13 @@
 
 	return tmp;
 }
+EXPORT_SYMBOL(strncat);
 #endif
 
 #ifndef __HAVE_ARCH_STRLCAT
+#ifdef strlcat
+#undef strlcat
+#endif
 /**
  * strlcat - Append a length-limited, %NUL-terminated string to another
  * @dest: The string to be appended to
@@ -202,6 +227,9 @@
 #endif
 
 #ifndef __HAVE_ARCH_STRCMP
+#ifdef strcmp
+#undef strcmp
+#endif
 /**
  * strcmp - Compare two strings
  * @cs: One string
@@ -218,9 +246,13 @@
 
 	return __res;
 }
+EXPORT_SYMBOL(strcmp);
 #endif
 
 #ifndef __HAVE_ARCH_STRNCMP
+#ifdef strncmp
+#undef strncmp
+#endif
 /**
  * strncmp - Compare two length-limited strings
  * @cs: One string
@@ -239,9 +271,13 @@
 
 	return __res;
 }
+EXPORT_SYMBOL(strncmp);
 #endif
 
 #ifndef __HAVE_ARCH_STRCHR
+#ifdef strchr
+#undef strchr
+#endif
 /**
  * strchr - Find the first occurrence of a character in a string
  * @s: The string to be searched
@@ -254,9 +290,13 @@
 			return NULL;
 	return (char *) s;
 }
+EXPORT_SYMBOL(strchr);
 #endif
 
 #ifndef __HAVE_ARCH_STRRCHR
+#ifdef strrchr
+#undef strrchr
+#endif
 /**
  * strrchr - Find the last occurrence of a character in a string
  * @s: The string to be searched
@@ -271,9 +311,13 @@
        } while (--p >= s);
        return NULL;
 }
+EXPORT_SYMBOL(strrchr);
 #endif
 
 #ifndef __HAVE_ARCH_STRNCHR
+#ifdef strnchr
+#undef strnchr
+#endif
 /**
  * strnchr - Find a character in a length limited string
  * @s: The string to be searched
@@ -287,9 +331,13 @@
 			return (char *) s;
 	return NULL;
 }
+EXPORT_SYMBOL(strnchr);
 #endif
 
 #ifndef __HAVE_ARCH_STRLEN
+#ifdef strlen
+#undef strlen
+#endif
 /**
  * strlen - Find the length of a string
  * @s: The string to be sized
@@ -302,9 +350,13 @@
 		/* nothing */;
 	return sc - s;
 }
+EXPORT_SYMBOL(strlen);
 #endif
 
 #ifndef __HAVE_ARCH_STRNLEN
+#ifdef strnlen
+#undef strnlen
+#endif
 /**
  * strnlen - Find the length of a length-limited string
  * @s: The string to be sized
@@ -318,9 +370,13 @@
 		/* nothing */;
 	return sc - s;
 }
+EXPORT_SYMBOL(strnlen);
 #endif
 
 #ifndef __HAVE_ARCH_STRSPN
+#ifdef strspn
+#undef strspn
+#endif
 /**
  * strspn - Calculate the length of the initial substring of @s which only
  * 	contain letters in @accept
@@ -349,6 +405,9 @@
 EXPORT_SYMBOL(strspn);
 #endif
 
+#ifdef strcspn
+#undef strcspn
+#endif
 /**
  * strcspn - Calculate the length of the initial substring of @s which does
  * 	not contain letters in @reject
@@ -371,8 +430,12 @@
 
 	return count;
 }	
+EXPORT_SYMBOL(strcspn);
 
 #ifndef __HAVE_ARCH_STRPBRK
+#ifdef strpbrk
+#undef strpbrk
+#endif
 /**
  * strpbrk - Find the first occurrence of a set of characters
  * @cs: The string to be searched
@@ -390,9 +453,13 @@
 	}
 	return NULL;
 }
+EXPORT_SYMBOL(strpbrk);
 #endif
 
 #ifndef __HAVE_ARCH_STRSEP
+#ifdef strsep
+#undef strsep
+#endif
 /**
  * strsep - Split a string into tokens
  * @s: The string to be searched
@@ -423,6 +490,9 @@
 #endif
 
 #ifndef __HAVE_ARCH_MEMSET
+#ifdef memset
+#undef memset
+#endif
 /**
  * memset - Fill a region of memory with the given value
  * @s: Pointer to the start of the area.
@@ -440,9 +510,13 @@
 
 	return s;
 }
+EXPORT_SYMBOL(memset);
 #endif
 
 #ifndef __HAVE_ARCH_BCOPY
+#ifdef bcopy
+#undef bcopy
+#endif
 /**
  * bcopy - Copy one area of memory to another
  * @src: Where to copy from
@@ -463,9 +537,13 @@
 	while (count--)
 		*dest++ = *src++;
 }
+EXPORT_SYMBOL(bcopy);
 #endif
 
 #ifndef __HAVE_ARCH_MEMCPY
+#ifdef memcpy
+#undef memcpy
+#endif
 /**
  * memcpy - Copy one area of memory to another
  * @dest: Where to copy to
@@ -484,9 +562,13 @@
 
 	return dest;
 }
+EXPORT_SYMBOL(memcpy);
 #endif
 
 #ifndef __HAVE_ARCH_MEMMOVE
+#ifdef memmove
+#undef memmove
+#endif
 /**
  * memmove - Copy one area of memory to another
  * @dest: Where to copy to
@@ -514,9 +596,13 @@
 
 	return dest;
 }
+EXPORT_SYMBOL(memmove);
 #endif
 
 #ifndef __HAVE_ARCH_MEMCMP
+#ifdef memcmp
+#undef memcmp
+#endif
 /**
  * memcmp - Compare two areas of memory
  * @cs: One area of memory
@@ -533,9 +619,13 @@
 			break;
 	return res;
 }
+EXPORT_SYMBOL(memcmp);
 #endif
 
 #ifndef __HAVE_ARCH_MEMSCAN
+#ifdef memscan
+#undef memscan
+#endif
 /**
  * memscan - Find a character in an area of memory.
  * @addr: The memory area
@@ -557,9 +647,13 @@
 	}
   	return (void *) p;
 }
+EXPORT_SYMBOL(memscan);
 #endif
 
 #ifndef __HAVE_ARCH_STRSTR
+#ifdef strstr
+#undef strstr
+#endif
 /**
  * strstr - Find the first substring in a %NUL terminated string
  * @s1: The string to be searched
@@ -581,9 +675,13 @@
 	}
 	return NULL;
 }
+EXPORT_SYMBOL(strstr);
 #endif
 
 #ifndef __HAVE_ARCH_MEMCHR
+#ifdef memchr
+#undef memchr
+#endif
 /**
  * memchr - Find a character in an area of memory.
  * @s: The memory area
@@ -603,5 +701,6 @@
 	}
 	return NULL;
 }
+EXPORT_SYMBOL(memchr);
 
 #endif

