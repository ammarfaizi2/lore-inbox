Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261393AbVARBF0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbVARBF0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 20:05:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261431AbVARBF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 20:05:26 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:62222 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261393AbVARBEw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 20:04:52 -0500
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/13] FAT: IS_BADCHAR/IS_REPLACECHR/IS_SKIPCHAR cleanup
References: <87pt04oszi.fsf@devron.myhome.or.jp>
	<87llasosxu.fsf@devron.myhome.or.jp>
	<87hdlgoswe.fsf_-_@devron.myhome.or.jp>
	<20050117183304.GT26051@parcelfarce.linux.theplanet.co.uk>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 18 Jan 2005 10:04:30 +0900
In-Reply-To: <20050117183304.GT26051@parcelfarce.linux.theplanet.co.uk> (Al
 Viro's message of "Mon, 17 Jan 2005 18:33:04 +0000")
Message-ID: <87mzv7lf8h.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@parcelfarce.linux.theplanet.co.uk> writes:

> Ugh...  What's wrong with comparison to '*', '<', etc.?  All values are
> below 0x80, so signedness of char doesn't matter and when they get
> promoted to int, they will give you the values you want...

Indeed.  Thanks.

Please apply the following incremental patch.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>



[PATCH 14] FAT: Further IS_BADCHAR/IS_REPLACECHR/IS_SKIPCHAR cleanup

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/vfat/namei.c |   15 ++++++---------
 1 files changed, 6 insertions(+), 9 deletions(-)

diff -puN fs/vfat/namei.c~fat_check-chars-cleanup2 fs/vfat/namei.c
--- linux-2.6.11-rc1/fs/vfat/namei.c~fat_check-chars-cleanup2	2005-01-18 09:50:45.000000000 +0900
+++ linux-2.6.11-rc1-hirofumi/fs/vfat/namei.c	2005-01-18 09:56:08.000000000 +0900
@@ -153,23 +153,20 @@ static struct dentry_operations vfat_den
 static inline wchar_t vfat_bad_char(wchar_t w)
 {
 	return (w < 0x0020)
-	    || (w == 0x002A) /* * */	|| (w == 0x003F) /* ? */
-	    || (w == 0x003C) /* < */	|| (w == 0x003E) /* > */
-	    || (w == 0x007C) /* | */	|| (w == 0x0022) /* " */
-	    || (w == 0x003A) /* : */	|| (w == 0x002F) /* / */
-	    || (w == 0x005C);/* \ */
+	    || (w == '*') || (w == '?') || (w == '<') || (w == '>')
+	    || (w == '|') || (w == '"') || (w == ':') || (w == '/')
+	    || (w == '\\');
 }
 
 static inline wchar_t vfat_replace_char(wchar_t w)
 {
-	return (w == 0x005B) /* [ */	|| (w == 0x005D) /* ] */
-	    || (w == 0x003B) /* ; */	|| (w == 0x002C) /* , */
-	    || (w == 0x002B) /* + */	|| (w == 0x003D);/* = */
+	return (w == '[') || (w == ']') || (w == ';') || (w == ',')
+	    || (w == '+') || (w == '=');
 }
 
 static wchar_t vfat_skip_char(wchar_t w)
 {
-	return (w == 0x002E) /* . */	|| (w == 0x0020);/* <space> */
+	return (w == '.') || (w == ' ');
 }
 
 static inline int vfat_is_used_badchars(const wchar_t *s, int len)
_
