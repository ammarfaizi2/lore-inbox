Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264650AbTFAPhc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 11:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264651AbTFAPhc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 11:37:32 -0400
Received: from miranda.zianet.com ([216.234.192.169]:24839 "HELO
	miranda.zianet.com") by vger.kernel.org with SMTP id S264650AbTFAPha
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 11:37:30 -0400
Subject: Re: Question about style when converting from K&R to ANSI C.
From: Steven Cole <elenstev@mesatop.com>
To: Larry McVoy <lm@bitmover.com>
Cc: Willy Tarreau <willy@w.ods.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20030601150951.GC3641@work.bitmover.com>
References: <1054446976.19557.23.camel@spc>
	 <20030601132626.GA3012@work.bitmover.com>
	 <20030601134942.GA10750@alpha.home.local>
	 <20030601140602.GA3641@work.bitmover.com> <1054479734.19552.51.camel@spc>
	 <20030601150951.GC3641@work.bitmover.com>
Content-Type: text/plain
Organization: 
Message-Id: <1054482640.19552.69.camel@spc>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 01 Jun 2003 09:50:40 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-06-01 at 09:09, Larry McVoy wrote:
> > /*ARGSUSED*/
> > -static unsigned long
> > -insert_bba (insn, value, errmsg)
> > -     unsigned long insn;
> > -     long value;
> > -     const char **errmsg;
> > +static unsigned long insert_bba(
> > +       unsigned long insn,
> > +       long value,
> > +       const char **errmsg
> > +)
> > {
> >    return insn | (((insn >> 16) & 0x1f) << 11);
> > }
> 
> Of the following, the original is clearly outdated so we can all agree that
> can go.  I'm not real found of Linus' style either.  What's wrong with the
> two traditional forms?
> 
> /* ============== original ============== */
> static unsigned long
> insert_bba (insn, value, errmsg)
> 	unsigned long insn;
> 	long value;
> 	const char **errmsg;
> {
> 	return insn | (((insn >> 16) & 0x1f) << 11);
> }
> 
> /* ============== linus ============== */
> static unsigned long insert_bba(
> 	unsigned long insn;
> 	long value;
> 	const char **errmsg;
> )
> {
> 	return insn | (((insn >> 16) & 0x1f) << 11);
> }
> 
> /* ============== traditional ============== */
> static unsigned long
> insert_bba(unsigned long insn; long value; const char **errmsg)
> {
> 	return insn | (((insn >> 16) & 0x1f) << 11);
> }
> 
> /* ============== traditional (lotso args) ============== */
> static unsigned long
> insert_bba(
> 	register unsigned const int some_big_fat_variable_name;
> 	unsigned long insn;
> 	long value;
> 	const char **errmsg)
> {
> 	return insn | (((insn >> 16) & 0x1f) << 11);
> }

Umm, I think those ";" should be "," otherwise you get a
parameter `insn' has just a forward declaration or some such error.

I have used more traditional style where the new Linus style was not
warranted.  Here is the patch for fs/jfs/jfs_xtree.c:

--- bk-current/fs/jfs/jfs_xtree.c	2003-05-31 20:30:47.000000000 -0600
+++ linux/fs/jfs/jfs_xtree.c	2003-05-31 21:02:14.000000000 -0600
@@ -4225,8 +4225,7 @@
  *      at the current entry at the current subtree root page
  *
  */
-int xtGather(t)
-btree_t *t;
+int xtGather(btree_t *t)
 {
 	int rc = 0;
 	xtpage_t *p;

I haven't yet sent that to the maintainer (worked until late last night
and still getting -ENOTENOUGHCOFFEE from brain).  

Anyway, I agree that more traditional styles should be used unless
otherwise indicated, but having the return type on the same line as the
function name is something I've warmed up to.  And I can remember
14-character filenames and being able to print out the entire kernel in
less than 20 minutes on the line printer.  That was 8 or 9 years before
linux 0.01.  Yes, I'm an old-fogey.

Steven

