Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261971AbVCVV2K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261971AbVCVV2K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 16:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261978AbVCVV2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 16:28:09 -0500
Received: from mail.dif.dk ([193.138.115.101]:52409 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261971AbVCVV1F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 16:27:05 -0500
Date: Tue, 22 Mar 2005 22:28:51 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: security/keys/key.c broken with defconfig
Message-ID: <Pine.LNX.4.62.0503222223180.2683@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If I just do a 'make defconfig' and then try to build security/keys/ the 
build breaks.  Doing 'make allyesconfig' fixes it by defining CONFIG_KEYS 
which makes include/linux/key-ui.h include the full struct key definition.

I've not attempted to fix this yet, but thought I'd at least report it.


juhl@dragon:~/download/kernel/linux-2.6.12-rc1-mm1$ make defconfig
juhl@dragon:~/download/kernel/linux-2.6.12-rc1-mm1$ make security/keys/
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/basic/split-include
  HOSTCC  scripts/basic/docproc
  CC      scripts/mod/empty.o
  HOSTCC  scripts/mod/mk_elfconfig
  MKELF   scripts/mod/elfconfig.h
  HOSTCC  scripts/mod/file2alias.o
  HOSTCC  scripts/mod/modpost.o
  HOSTCC  scripts/mod/sumversion.o
  HOSTLD  scripts/mod/modpost
  HOSTCC  scripts/kallsyms
  HOSTCC  scripts/conmakehash
  CHK     include/linux/version.h
  CC      arch/i386/kernel/asm-offsets.s
  CHK     include/asm-i386/asm_offsets.h
  UPD     include/asm-i386/asm_offsets.h
  CC      security/keys/key.o
In file included from security/keys/internal.h:16,
                 from security/keys/key.c:18:
include/linux/key-ui.h: In function `key_permission':
include/linux/key-ui.h:49: error: dereferencing pointer to incomplete type
include/linux/key-ui.h:50: error: dereferencing pointer to incomplete type
include/linux/key-ui.h:51: error: dereferencing pointer to incomplete type
include/linux/key-ui.h:52: error: dereferencing pointer to incomplete type
include/linux/key-ui.h:52: error: `KEY_GRP_ALL' undeclared (first use in this function)
include/linux/key-ui.h:52: error: (Each undeclared identifier is reported only once
include/linux/key-ui.h:52: error: for each function it appears in.)
include/linux/key-ui.h:53: error: dereferencing pointer to incomplete type
include/linux/key-ui.h:55: error: dereferencing pointer to incomplete type
include/linux/key-ui.h:57: error: dereferencing pointer to incomplete type
include/linux/key-ui.h: In function `key_any_permission':
include/linux/key-ui.h:72: error: dereferencing pointer to incomplete type
include/linux/key-ui.h:73: error: dereferencing pointer to incomplete type
include/linux/key-ui.h:74: error: dereferencing pointer to incomplete type
include/linux/key-ui.h:75: error: dereferencing pointer to incomplete type
include/linux/key-ui.h:75: error: `KEY_GRP_ALL' undeclared (first use in this function)
include/linux/key-ui.h:76: error: dereferencing pointer to incomplete type
include/linux/key-ui.h:78: error: dereferencing pointer to incomplete type
include/linux/key-ui.h:80: error: dereferencing pointer to incomplete type
security/keys/key.c: At top level:
security/keys/key.c:38: error: variable `key_type_dead' has initializer but incomplete type
security/keys/key.c:39: error: unknown field `name' specified in initializer
security/keys/key.c:39: warning: excess elements in struct initializer
security/keys/key.c:39: warning: (near initialization for `key_type_dead')
security/keys/key.c: In function `__key_insert_serial':
security/keys/key.c:153: error: dereferencing pointer to incomplete type
security/keys/key.c:153: warning: type defaults to `int' in declaration of `__mptr'
security/keys/key.c:153: warning: initialization from incompatible pointer type
security/keys/key.c:153: error: dereferencing pointer to incomplete type
security/keys/key.c:155: error: dereferencing pointer to incomplete type
security/keys/key.c:155: error: dereferencing pointer to incomplete type
security/keys/key.c:157: error: dereferencing pointer to incomplete type
security/keys/key.c:157: error: dereferencing pointer to incomplete type
security/keys/key.c:164: error: dereferencing pointer to incomplete type
security/keys/key.c:165: error: dereferencing pointer to incomplete type
security/keys/key.c: In function `key_alloc_serial':
security/keys/key.c:184: error: dereferencing pointer to incomplete type
security/keys/key.c:185: error: dereferencing pointer to incomplete type
security/keys/key.c:186: error: dereferencing pointer to incomplete type
security/keys/key.c:187: error: dereferencing pointer to incomplete type
security/keys/key.c:194: error: dereferencing pointer to incomplete type
security/keys/key.c:194: warning: type defaults to `int' in declaration of `__mptr'
security/keys/key.c:194: warning: initialization from incompatible pointer type
security/keys/key.c:194: error: dereferencing pointer to incomplete type
security/keys/key.c:196: error: dereferencing pointer to incomplete type
security/keys/key.c:196: error: dereferencing pointer to incomplete type
security/keys/key.c:198: error: dereferencing pointer to incomplete type
security/keys/key.c:198: error: dereferencing pointer to incomplete type
security/keys/key.c:209: error: dereferencing pointer to incomplete type
security/keys/key.c:210: error: dereferencing pointer to incomplete type
security/keys/key.c:211: error: dereferencing pointer to incomplete type
security/keys/key.c:212: error: dereferencing pointer to incomplete type
security/keys/key.c:225: error: dereferencing pointer to incomplete type
security/keys/key.c:225: warning: type defaults to `int' in declaration of `__mptr'
security/keys/key.c:225: warning: initialization from incompatible pointer type
security/keys/key.c:225: error: dereferencing pointer to incomplete type
security/keys/key.c:226: error: dereferencing pointer to incomplete type
security/keys/key.c:226: error: dereferencing pointer to incomplete type
security/keys/key.c:232: error: dereferencing pointer to incomplete type
security/keys/key.c:233: error: dereferencing pointer to incomplete type
security/keys/key.c: In function `key_alloc':
security/keys/key.c:262: error: dereferencing pointer to incomplete type
security/keys/key.c:289: error: dereferencing pointer to incomplete type
security/keys/key.c:290: error: dereferencing pointer to incomplete type
security/keys/key.c:293: error: dereferencing pointer to incomplete type
security/keys/key.c:293: error: dereferencing pointer to incomplete type
security/keys/key.c:296: error: dereferencing pointer to incomplete type
security/keys/key.c:297: error: dereferencing pointer to incomplete type
security/keys/key.c:298: error: dereferencing pointer to incomplete type
security/keys/key.c:299: error: dereferencing pointer to incomplete type
security/keys/key.c:300: error: dereferencing pointer to incomplete type
security/keys/key.c:301: error: dereferencing pointer to incomplete type
security/keys/key.c:301: error: dereferencing pointer to incomplete type
security/keys/key.c:302: error: dereferencing pointer to incomplete type
security/keys/key.c:303: error: dereferencing pointer to incomplete type
security/keys/key.c:304: error: dereferencing pointer to incomplete type
security/keys/key.c:305: error: dereferencing pointer to incomplete type
security/keys/key.c:306: error: dereferencing pointer to incomplete type
security/keys/key.c:307: error: dereferencing pointer to incomplete type
security/keys/key.c:310: error: dereferencing pointer to incomplete type
security/keys/key.c:310: error: `KEY_FLAG_IN_QUOTA' undeclared (first use in this function)
security/keys/key.c:312: error: dereferencing pointer to incomplete type
security/keys/key.c:312: error: dereferencing pointer to incomplete type
security/keys/key.c:312: error: dereferencing pointer to incomplete type
security/keys/key.c:312: error: dereferencing pointer to incomplete type
security/keys/key.c:312: error: dereferencing pointer to incomplete type
security/keys/key.c:312: error: dereferencing pointer to incomplete type
security/keys/key.c:312: error: dereferencing pointer to incomplete type
security/keys/key.c:312: error: dereferencing pointer to incomplete type
security/keys/key.c:312: error: dereferencing pointer to incomplete type
security/keys/key.c:312: error: dereferencing pointer to incomplete type
security/keys/key.c: In function `key_payload_reserve':
security/keys/key.c:355: error: dereferencing pointer to incomplete type
security/keys/key.c:361: error: `KEY_FLAG_IN_QUOTA' undeclared (first use in this function)
security/keys/key.c:361: error: dereferencing pointer to incomplete type
security/keys/key.c:361: error: dereferencing pointer to incomplete type
security/keys/key.c:362: error: dereferencing pointer to incomplete type
security/keys/key.c:365: error: dereferencing pointer to incomplete type
security/keys/key.c:370: error: dereferencing pointer to incomplete type
security/keys/key.c:371: error: dereferencing pointer to incomplete type
security/keys/key.c:373: error: dereferencing pointer to incomplete type
security/keys/key.c:378: error: dereferencing pointer to incomplete type
security/keys/key.c: In function `__key_instantiate_and_link':
security/keys/key.c:407: error: `KEY_FLAG_INSTANTIATED' undeclared (first use in this function)
security/keys/key.c:407: error: dereferencing pointer to incomplete type
security/keys/key.c:407: error: dereferencing pointer to incomplete type
security/keys/key.c:409: error: dereferencing pointer to incomplete type
security/keys/key.c:413: error: dereferencing pointer to incomplete type
security/keys/key.c:414: error: dereferencing pointer to incomplete type
security/keys/key.c:416: error: `KEY_FLAG_USER_CONSTRUCT' undeclared (first use in this function)
security/keys/key.c:416: error: dereferencing pointer to incomplete type
security/keys/key.c: In function `key_instantiate_and_link':
security/keys/key.c:447: error: dereferencing pointer to incomplete type
security/keys/key.c:452: error: dereferencing pointer to incomplete type
security/keys/key.c: In function `key_negate_and_link':
security/keys/key.c:477: error: dereferencing pointer to incomplete type
security/keys/key.c:482: error: `KEY_FLAG_INSTANTIATED' undeclared (first use in this function)
security/keys/key.c:482: error: dereferencing pointer to incomplete type
security/keys/key.c:482: error: dereferencing pointer to incomplete type
security/keys/key.c:484: error: dereferencing pointer to incomplete type
security/keys/key.c:485: error: `KEY_FLAG_NEGATIVE' undeclared (first use in this function)
security/keys/key.c:485: error: dereferencing pointer to incomplete type
security/keys/key.c:486: error: dereferencing pointer to incomplete type
security/keys/key.c:488: error: dereferencing pointer to incomplete type
security/keys/key.c:490: error: `KEY_FLAG_USER_CONSTRUCT' undeclared (first use in this function)
security/keys/key.c:490: error: dereferencing pointer to incomplete type
security/keys/key.c:503: error: dereferencing pointer to incomplete type
security/keys/key.c: In function `key_cleanup':
security/keys/key.c:530: error: dereferencing pointer to incomplete type
security/keys/key.c:530: warning: type defaults to `int' in declaration of `__mptr'
security/keys/key.c:530: warning: initialization from incompatible pointer type
security/keys/key.c:530: error: dereferencing pointer to incomplete type
security/keys/key.c:532: error: dereferencing pointer to incomplete type
security/keys/key.c:542: error: dereferencing pointer to incomplete type
security/keys/key.c:548: error: `KEY_FLAG_IN_QUOTA' undeclared (first use in this function)
security/keys/key.c:548: error: dereferencing pointer to incomplete type
security/keys/key.c:548: error: dereferencing pointer to incomplete type
security/keys/key.c:549: error: dereferencing pointer to incomplete type
security/keys/key.c:550: error: dereferencing pointer to incomplete type
security/keys/key.c:551: error: dereferencing pointer to incomplete type
security/keys/key.c:551: error: dereferencing pointer to incomplete type
security/keys/key.c:552: error: dereferencing pointer to incomplete type
security/keys/key.c:555: error: dereferencing pointer to incomplete type
security/keys/key.c:556: error: `KEY_FLAG_INSTANTIATED' undeclared (first use in this function)
security/keys/key.c:556: error: dereferencing pointer to incomplete type
security/keys/key.c:556: error: dereferencing pointer to incomplete type
security/keys/key.c:557: error: dereferencing pointer to incomplete type
security/keys/key.c:559: error: dereferencing pointer to incomplete type
security/keys/key.c:562: error: dereferencing pointer to incomplete type
security/keys/key.c:563: error: dereferencing pointer to incomplete type
security/keys/key.c:565: error: dereferencing pointer to incomplete type
security/keys/key.c: At top level:
security/keys/key.c:583: error: parse error before "do"
security/keys/key.c:594: error: `key_put' undeclared here (not in a function)
security/keys/key.c:594: error: initializer element is not constant
security/keys/key.c:594: error: (near initialization for `__ksymtab_key_put.value')
security/keys/key.c: In function `key_lookup':
security/keys/key.c:610: error: dereferencing pointer to incomplete type
security/keys/key.c:610: warning: type defaults to `int' in declaration of `__mptr'
security/keys/key.c:610: warning: initialization from incompatible pointer type
security/keys/key.c:610: error: dereferencing pointer to incomplete type
security/keys/key.c:612: error: dereferencing pointer to incomplete type
security/keys/key.c:614: error: dereferencing pointer to incomplete type
security/keys/key.c:626: error: dereferencing pointer to incomplete type
security/keys/key.c:627: error: `KEY_FLAG_DEAD' undeclared (first use in this function)
security/keys/key.c:627: error: dereferencing pointer to incomplete type
security/keys/key.c:627: error: dereferencing pointer to incomplete type
security/keys/key.c:628: error: dereferencing pointer to incomplete type
security/keys/key.c:634: error: dereferencing pointer to incomplete type
security/keys/key.c: In function `key_type_lookup':
security/keys/key.c:655: error: dereferencing pointer to incomplete type
security/keys/key.c:655: warning: type defaults to `int' in declaration of `type name'
security/keys/key.c:655: error: request for member `link' in something not a structure or union
security/keys/key.c:655: warning: type defaults to `int' in declaration of `__mptr'
security/keys/key.c:655: warning: initialization from incompatible pointer type
security/keys/key.c:655: error: dereferencing pointer to incomplete type
security/keys/key.c:655: error: dereferencing pointer to incomplete type
security/keys/key.c:655: warning: type defaults to `int' in declaration of `type name'
security/keys/key.c:655: error: request for member `link' in something not a structure or union
security/keys/key.c:655: warning: type defaults to `int' in declaration of `type name'
security/keys/key.c:655: error: dereferencing pointer to incomplete type
security/keys/key.c:655: error: dereferencing pointer to incomplete type
security/keys/key.c:655: error: dereferencing pointer to incomplete type
security/keys/key.c:655: warning: type defaults to `int' in declaration of `type name'
security/keys/key.c:655: error: request for member `link' in something not a structure or union
security/keys/key.c:655: warning: type defaults to `int' in declaration of `__mptr'
security/keys/key.c:655: error: dereferencing pointer to incomplete type
security/keys/key.c:655: error: dereferencing pointer to incomplete type
security/keys/key.c:655: error: dereferencing pointer to incomplete type
security/keys/key.c:655: warning: type defaults to `int' in declaration of `type name'
security/keys/key.c:655: error: request for member `link' in something not a structure or union
security/keys/key.c:655: warning: type defaults to `int' in declaration of `type name'
security/keys/key.c:656: error: dereferencing pointer to incomplete type
security/keys/key.c: In function `__key_update':
security/keys/key.c:695: error: dereferencing pointer to incomplete type
security/keys/key.c:698: error: dereferencing pointer to incomplete type
security/keys/key.c:700: error: dereferencing pointer to incomplete type
security/keys/key.c:704: error: `KEY_FLAG_NEGATIVE' undeclared (first use in this function)
security/keys/key.c:704: error: dereferencing pointer to incomplete type
security/keys/key.c:706: error: dereferencing pointer to incomplete type
security/keys/key.c: In function `key_create_or_update':
security/keys/key.c:748: error: dereferencing pointer to incomplete type
security/keys/key.c:748: error: dereferencing pointer to incomplete type
security/keys/key.c:754: error: dereferencing pointer to incomplete type
security/keys/key.c:767: error: `KEY_USR_VIEW' undeclared (first use in this function)
security/keys/key.c:767: error: `KEY_USR_SEARCH' undeclared (first use in this function)
security/keys/key.c:767: error: `KEY_USR_LINK' undeclared (first use in this function)
security/keys/key.c:769: error: dereferencing pointer to incomplete type
security/keys/key.c:770: error: `KEY_USR_READ' undeclared (first use in this function)
security/keys/key.c:772: error: `key_type_keyring' undeclared (first use in this function)
security/keys/key.c:772: error: dereferencing pointer to incomplete type
security/keys/key.c:773: error: `KEY_USR_WRITE' undeclared (first use in this function)
security/keys/key.c:791: error: dereferencing pointer to incomplete type
security/keys/key.c:801: error: dereferencing pointer to incomplete type
security/keys/key.c: In function `key_update':
security/keys/key.c:828: error: dereferencing pointer to incomplete type
security/keys/key.c:829: error: dereferencing pointer to incomplete type
security/keys/key.c:830: error: dereferencing pointer to incomplete type
security/keys/key.c:834: error: `KEY_FLAG_NEGATIVE' undeclared (first use in this function)
security/keys/key.c:834: error: dereferencing pointer to incomplete type
security/keys/key.c:836: error: dereferencing pointer to incomplete type
security/keys/key.c: In function `key_duplicate':
security/keys/key.c:859: error: dereferencing pointer to incomplete type
security/keys/key.c:864: error: dereferencing pointer to incomplete type
security/keys/key.c:868: error: dereferencing pointer to incomplete type
security/keys/key.c:869: error: dereferencing pointer to incomplete type
security/keys/key.c:873: error: dereferencing pointer to incomplete type
security/keys/key.c:874: error: dereferencing pointer to incomplete type
security/keys/key.c:875: error: dereferencing pointer to incomplete type
security/keys/key.c:879: error: dereferencing pointer to incomplete type
security/keys/key.c:880: error: `KEY_FLAG_INSTANTIATED' undeclared (first use in this function)
security/keys/key.c:880: error: dereferencing pointer to incomplete type
security/keys/key.c: In function `key_revoke':
security/keys/key.c:906: error: dereferencing pointer to incomplete type
security/keys/key.c:907: error: `KEY_FLAG_REVOKED' undeclared (first use in this function)
security/keys/key.c:907: error: dereferencing pointer to incomplete type
security/keys/key.c:908: error: dereferencing pointer to incomplete type
security/keys/key.c: In function `register_key_type':
security/keys/key.c:927: error: dereferencing pointer to incomplete type
security/keys/key.c:927: warning: type defaults to `int' in declaration of `type name'
security/keys/key.c:927: error: request for member `link' in something not a structure or union
security/keys/key.c:927: warning: type defaults to `int' in declaration of `__mptr'
security/keys/key.c:927: warning: initialization from incompatible pointer type
security/keys/key.c:927: error: dereferencing pointer to incomplete type
security/keys/key.c:927: error: dereferencing pointer to incomplete type
security/keys/key.c:927: warning: type defaults to `int' in declaration of `type name'
security/keys/key.c:927: error: request for member `link' in something not a structure or union
security/keys/key.c:927: warning: type defaults to `int' in declaration of `type name'
security/keys/key.c:927: error: dereferencing pointer to incomplete type
security/keys/key.c:927: error: dereferencing pointer to incomplete type
security/keys/key.c:927: error: dereferencing pointer to incomplete type
security/keys/key.c:927: warning: type defaults to `int' in declaration of `type name'
security/keys/key.c:927: error: request for member `link' in something not a structure or union
security/keys/key.c:927: warning: type defaults to `int' in declaration of `__mptr'
security/keys/key.c:927: error: dereferencing pointer to incomplete type
security/keys/key.c:927: error: dereferencing pointer to incomplete type
security/keys/key.c:927: error: dereferencing pointer to incomplete type
security/keys/key.c:927: warning: type defaults to `int' in declaration of `type name'
security/keys/key.c:927: error: request for member `link' in something not a structure or union
security/keys/key.c:927: warning: type defaults to `int' in declaration of `type name'
security/keys/key.c:928: error: dereferencing pointer to incomplete type
security/keys/key.c:928: error: dereferencing pointer to incomplete type
security/keys/key.c:933: error: dereferencing pointer to incomplete type
security/keys/key.c: In function `unregister_key_type':
security/keys/key.c:956: error: dereferencing pointer to incomplete type
security/keys/key.c:962: error: dereferencing pointer to incomplete type
security/keys/key.c:962: warning: type defaults to `int' in declaration of `__mptr'
security/keys/key.c:962: warning: initialization from incompatible pointer type
security/keys/key.c:962: error: dereferencing pointer to incomplete type
security/keys/key.c:964: error: dereferencing pointer to incomplete type
security/keys/key.c:965: error: dereferencing pointer to incomplete type
security/keys/key.c:978: error: dereferencing pointer to incomplete type
security/keys/key.c:978: warning: type defaults to `int' in declaration of `__mptr'
security/keys/key.c:978: warning: initialization from incompatible pointer type
security/keys/key.c:978: error: dereferencing pointer to incomplete type
security/keys/key.c:980: error: dereferencing pointer to incomplete type
security/keys/key.c:981: error: dereferencing pointer to incomplete type
security/keys/key.c:982: error: dereferencing pointer to incomplete type
security/keys/key.c:983: error: dereferencing pointer to incomplete type
security/keys/key.c:983: error: dereferencing pointer to incomplete type
security/keys/key.c:983: error: dereferencing pointer to incomplete type
security/keys/key.c:983: error: dereferencing pointer to incomplete type
security/keys/key.c:983: error: dereferencing pointer to incomplete type
security/keys/key.c:983: error: dereferencing pointer to incomplete type
security/keys/key.c:983: error: dereferencing pointer to incomplete type
security/keys/key.c:983: error: dereferencing pointer to incomplete type
security/keys/key.c:983: error: dereferencing pointer to incomplete type
security/keys/key.c:983: error: dereferencing pointer to incomplete type
security/keys/key.c:998:26: macro "key_init" passed 1 arguments, but takes just 0
security/keys/key.c: At top level:
security/keys/key.c:999: error: syntax error before '{' token
security/keys/key.c:1005: error: parse error before '&' token
security/keys/key.c:1005: warning: type defaults to `int' in declaration of `list_add_tail'
security/keys/key.c:1005: warning: function declaration isn't a prototype
security/keys/key.c:1005: error: conflicting types for 'list_add_tail'
include/linux/list.h:81: error: previous definition of 'list_add_tail' was here
security/keys/key.c:1005: warning: data definition has no type or storage class
security/keys/key.c:1006: error: parse error before '&' token
security/keys/key.c:1006: warning: type defaults to `int' in declaration of `list_add_tail'
security/keys/key.c:1006: warning: function declaration isn't a prototype
security/keys/key.c:1006: warning: data definition has no type or storage class
security/keys/key.c:1007: error: parse error before '&' token
security/keys/key.c:1007: warning: type defaults to `int' in declaration of `list_add_tail'
security/keys/key.c:1007: warning: function declaration isn't a prototype
security/keys/key.c:1007: warning: data definition has no type or storage class
security/keys/key.c:1010: error: parse error before '&' token
security/keys/key.c:1014: error: parse error before '&' token
security/keys/key.c:1015: warning: type defaults to `int' in declaration of `rb_insert_color'
security/keys/key.c:1015: warning: function declaration isn't a prototype
security/keys/key.c:1015: error: conflicting types for 'rb_insert_color'
include/linux/rbtree.h:118: error: previous declaration of 'rb_insert_color' was here
security/keys/key.c:1015: error: conflicting types for 'rb_insert_color'
include/linux/rbtree.h:118: error: previous declaration of 'rb_insert_color' was here
security/keys/key.c:1015: warning: data definition has no type or storage class
security/keys/key.c:1021: error: parse error before '&' token
security/keys/key.c:1021: warning: type defaults to `int' in declaration of `__key_insert_serial'
security/keys/key.c:1021: warning: function declaration isn't a prototype
security/keys/key.c:1021: error: conflicting types for '__key_insert_serial'
security/keys/key.c:144: error: previous definition of '__key_insert_serial' was here
security/keys/key.c:1021: warning: data definition has no type or storage class
security/keys/key.c:1022: error: parse error before '&' token
security/keys/key.c:1022: warning: type defaults to `int' in declaration of `__key_insert_serial'
security/keys/key.c:1022: warning: function declaration isn't a prototype
security/keys/key.c:1022: warning: data definition has no type or storage class
security/keys/key.c:1024: error: parse error before '&' token
security/keys/key.c:1024: warning: type defaults to `int' in declaration of `keyring_publish_name'
security/keys/key.c:1024: warning: function declaration isn't a prototype
security/keys/key.c:1024: error: conflicting types for 'keyring_publish_name'
security/keys/internal.h:60: error: previous declaration of 'keyring_publish_name' was here
security/keys/key.c:1024: error: conflicting types for 'keyring_publish_name'
security/keys/internal.h:60: error: previous declaration of 'keyring_publish_name' was here
security/keys/key.c:1024: warning: data definition has no type or storage class
security/keys/key.c:1025: error: parse error before '&' token
security/keys/key.c:1025: warning: type defaults to `int' in declaration of `keyring_publish_name'
security/keys/key.c:1025: warning: function declaration isn't a prototype
security/keys/key.c:1025: warning: data definition has no type or storage class
security/keys/key.c:1028: error: parse error before '&' token
security/keys/key.c:1028: warning: type defaults to `int' in declaration of `key_link'
security/keys/key.c:1028: warning: function declaration isn't a prototype
security/keys/key.c:1028: warning: data definition has no type or storage class
security/keys/key.c:38: error: storage size of `key_type_dead' isn't known
security/keys/key.c:594: error: __ksymtab_key_put causes a section type conflict
security/keys/key.c:144: warning: '__key_insert_serial' defined but not used
make[1]: *** [security/keys/key.o] Error 1
make: *** [security/keys/] Error 2



-- 
Jesper Juhl


