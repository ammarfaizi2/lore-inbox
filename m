Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265972AbUBBTsy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 14:48:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265961AbUBBTrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 14:47:48 -0500
Received: from mailr-1.tiscali.it ([212.123.84.81]:15449 "EHLO
	mailr-1.tiscali.it") by vger.kernel.org with ESMTP id S265865AbUBBTq7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 14:46:59 -0500
X-BrightmailFiltered: true
Date: Mon, 2 Feb 2004 20:46:58 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [Compile Regression in 2.4.25-pre8][PATCH 16/42]
Message-ID: <20040202194658.GP6785@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <20040130204956.GA21643@dreamland.darkstar.lan> <Pine.LNX.4.58L.0401301855410.3140@logos.cnet> <20040202180940.GA6367@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040202180940.GA6367@dreamland.darkstar.lan>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


gamma_dma.c:608:18: warning: #warning list_entry() is needed here

Use list entry to get the container struct. Same thing applies to
drmP.h.

diff -Nru -X dontdiff linux-2.4-vanilla/drivers/char/drm/drmP.h linux-2.4/drivers/char/drm/drmP.h
--- linux-2.4-vanilla/drivers/char/drm/drmP.h	Sat Jan 31 15:54:42 2004
+++ linux-2.4/drivers/char/drm/drmP.h	Sat Jan 31 17:35:18 2004
@@ -344,7 +344,7 @@
 do {									\
 	struct list_head *_list;					\
 	list_for_each( _list, &dev->maplist->head ) {			\
-		drm_map_list_t *_entry = (drm_map_list_t *)_list;	\
+		drm_map_list_t *_entry = list_entry(_list, drm_map_list_t, head);	\
 		if ( _entry->map &&					\
 		     _entry->map->offset == (_o) ) {			\
 			(_map) = _entry->map;				\
diff -Nru -X dontdiff linux-2.4-vanilla/drivers/char/drm/gamma_dma.c linux-2.4/drivers/char/drm/gamma_dma.c
--- linux-2.4-vanilla/drivers/char/drm/gamma_dma.c	Sat Jan 31 15:54:42 2004
+++ linux-2.4/drivers/char/drm/gamma_dma.c	Sat Jan 31 17:35:52 2004
@@ -605,8 +605,7 @@
 	memset( dev_priv, 0, sizeof(drm_gamma_private_t) );
 
 	list_for_each(list, &dev->maplist->head) {
-		#warning list_entry() is needed here
-		drm_map_list_t *r_list = (drm_map_list_t *)list;
+		drm_map_list_t *r_list = list_entry(list, drm_map_list_t, head);
 		if( r_list->map &&
 		    r_list->map->type == _DRM_SHM &&
 		    r_list->map->flags & _DRM_CONTAINS_LOCK ) {

-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Il coraggio non mi manca.
E` la paura che mi frega...
