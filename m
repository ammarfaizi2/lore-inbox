Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261970AbVC1SGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261970AbVC1SGu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 13:06:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261980AbVC1Ror
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 12:44:47 -0500
Received: from fep16.inet.fi ([194.251.242.241]:12674 "EHLO fep16.inet.fi")
	by vger.kernel.org with ESMTP id S261971AbVC1Rln (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 12:41:43 -0500
Subject: [PATCH 3/9] isofs: inline macros in rock.c
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <ie2p4d.yvvame.c800krzha66tsbfqmvrvx2swh.refire@cs.helsinki.fi>
In-Reply-To: <ie2p45.fn0xkb.3bgqrzdsi2bnjwwpzvx2x3vr3.refire@cs.helsinki.fi>
Date: Mon, 28 Mar 2005 20:41:42 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch inlines the CHECK_CE macro in fs/isofs/rock.c.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 rock.c |   23 +++++++++++++++--------
 1 files changed, 15 insertions(+), 8 deletions(-)

Index: 2.6/fs/isofs/rock.c
===================================================================
--- 2.6.orig/fs/isofs/rock.c	2005-03-28 16:27:40.000000000 +0300
+++ 2.6/fs/isofs/rock.c	2005-03-28 16:27:47.000000000 +0300
@@ -38,11 +38,6 @@
    same thing in certain places.  We use the macros to ensure that everything
    is done correctly */
 
-#define CHECK_CE	       			\
-      {cont_extent = isonum_733(rr->u.CE.extent); \
-      cont_offset = isonum_733(rr->u.CE.offset); \
-      cont_size = isonum_733(rr->u.CE.size);}
-
 #define SETUP_ROCK_RIDGE(DE,CHR,LEN)	      		      	\
   {LEN= sizeof(struct iso_directory_record) + DE->name_len[0];	\
   if(LEN & 1) LEN++;						\
@@ -124,7 +119,11 @@
 				CHECK_SP(goto out);
 				break;
 			case SIG('C', 'E'):
-				CHECK_CE;
+				{
+					cont_extent = isonum_733(rr->u.CE.extent);
+					cont_offset = isonum_733(rr->u.CE.offset);
+					cont_size = isonum_733(rr->u.CE.size);
+				}
 				break;
 			case SIG('N', 'M'):
 				if (truncate)
@@ -224,7 +223,11 @@
 				CHECK_SP(goto out);
 				break;
 			case SIG('C', 'E'):
-				CHECK_CE;
+				{
+					cont_extent = isonum_733(rr->u.CE.extent);
+					cont_offset = isonum_733(rr->u.CE.offset);
+					cont_size = isonum_733(rr->u.CE.size);
+				}
 				break;
 			case SIG('E', 'R'):
 				ISOFS_SB(inode->i_sb)->s_rock = 1;
@@ -585,7 +588,11 @@
 			break;
 		case SIG('C', 'E'):
 			/* This tells is if there is a continuation record */
-			CHECK_CE;
+			{
+				cont_extent = isonum_733(rr->u.CE.extent);
+				cont_offset = isonum_733(rr->u.CE.offset);
+				cont_size = isonum_733(rr->u.CE.size);
+			}
 		default:
 			break;
 		}
