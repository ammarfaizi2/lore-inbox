Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261311AbUL2CtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbUL2CtP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 21:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbUL2CtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 21:49:15 -0500
Received: from mail.dif.dk ([193.138.115.101]:11717 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261311AbUL2Cs6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 21:48:58 -0500
Date: Wed, 29 Dec 2004 03:59:55 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Steve French <sfrench@samba.org>, Steve French <sfrench@us.ibm.com>,
       samba-technical <samba-technical@lists.samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2/3] whitespace cleanups in fs/cifs/file.c
In-Reply-To: <20041229015716.GB29323@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.61.0412290347020.28589@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0412270019370.3552@dragon.hygekrogen.localhost>
 <1104104286.16545.7.camel@localhost.localdomain>
 <Pine.LNX.4.61.0412290048150.3528@dragon.hygekrogen.localhost>
 <20041229015716.GB29323@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Dec 2004, Jörn Engel wrote:

> On Wed, 29 December 2004 00:52:32 +0100, Jesper Juhl wrote:
> > -		if(file->private_data != NULL) {
> > +		if (file->private_data != NULL) {
> 
> 		if (file->private_data) {
> 
> It's a question of taste, but in most cases I consider the shorter
> version to be more obvious.
> 
Yeah, matter of personal preference, but since both styles are used in the 
file I had to pick one of them to try and make it consistent - I simply 
picked my personally prefered form.






> > -static int cifs_relock_file(struct cifsFileInfo * cifsFile)
> > +static int 
> > +cifs_relock_file(struct cifsFileInfo *cifsFile)
> 
> Linus viciously prefers to keep return type and function name on a
> single line.  I cannot quite follow his reasoning, but would leave
> that part out, unless explicitly requested by Steve.
> 
Again, this was a matter of trying to achieve internal concistency within 
the file. 


> > -/*	buf = kmalloc(sizeof(FILE_ALL_INFO),GFP_KERNEL);
> > -	if(buf==0) {
> > +/*	buf = kmalloc(sizeof(FILE_ALL_INFO), GFP_KERNEL);
> > +	if (buf==0) {
> 
> Commented out?  Oh well, doesn't hurt either way.
> 
I was going through a few thousand lines I figured I might as well go 
through the commented out bits as well while I was at it ;)


> > @@ -408,7 +410,7 @@ cifs_close(struct inode *inode, struct f
> >  	struct cifs_sb_info *cifs_sb;
> >  	struct cifsTconInfo *pTcon;
> >  	struct cifsFileInfo *pSMBFile =
> > -		(struct cifsFileInfo *) file->private_data;
> > +		(struct cifsFileInfo *)file->private_data;
> 
> 	struct cifsFileInfo *pSMBFile = file->private_data;
> 
> Casting a typeless pointer is pointless.
> 
This was a 'whitespace fixes only' patch. I have no problem with going 
through the file and looking for pointless casts etc, but that would be a 
sepperate patch.




> >  	struct cifsFileInfo *pCFileStruct =
> > -	    (struct cifsFileInfo *) file->private_data;
> > -	char * ptmp;
> > +	    (struct cifsFileInfo *)file->private_data;
> > +	char *ptmp;
> 
> dito
> 
> > @@ -563,7 +565,7 @@ cifs_lock(struct file *file, int cmd, st
> >  
> >  	if (IS_GETLK(cmd)) {
> >  		rc = CIFSSMBLock(xid, pTcon,
> > -				 ((struct cifsFileInfo *) file->
> > +				 ((struct cifsFileInfo *)file->
> >  				  private_data)->netfid,
> >  				 length,
> >  				 pfLock->fl_start, 0, 1, lockType,
> 




> > -	if(file->f_dentry) {
> > -		if(file->f_dentry->d_inode) {
> > +	if (file->f_dentry) {
> > +		if (file->f_dentry->d_inode) {
> 
> 	if (file->f_dentry && file->f_dentry->d_inode) {
> 
> There is too little context to see if this conversion is possible.
> And I'm too lazy to check myself.
> 
I didn't check that either since that's not what this patch was about - it 
was strictly formatting/whitespace cleanups and no code changes.


> > -		} else
> > +		} else {
> >  			*poffset += bytes_written;
> > +		}
> 
> Don't.  The extra brackets only cost extra lines on your display.
> Most people are unaware of it, but the square-inch of display area is
> the single most expensive part of most workstations.  Don't waste it.
> 
Yes, they cost screen space, but sometimes they also make things more 
readable even when not strictly needed - when that was (IMO) the case, I 
added the brackets... doesn't matter much - Steve's decition :)


> > -		rc = cifs_write(file, page_data+offset,to-offset,
> > +		rc = cifs_write(file, page_data+offset, to-offset,
> >                                          &position);
> 
> Combining those two lines should still be within the 80 column budget.
> 
Right, I overlooked that (I've probably overlooked a bunch of other stuff 
- there was a lot of lines in there ;)


> > -			memset(target+bytes_read,0,PAGE_CACHE_SIZE-bytes_read);
> > +			memset(target + bytes_read, 0, PAGE_CACHE_SIZE - bytes_read);
> 				     ^ ^			      ^ ^
> I'd remove those four spaces again.  It's very personal, agreed.  Imo,
> the arithmetic operators and the commmata have different precedence on
> the semantical level, so it helps me to have different syntax here as
> well.  But surely many people will disagree and most Just Don't
> Care(tm).
> 
I made those changes since (again) both styles are used in the file, so to 
make it consistent I had to choose one of the styles, and picked my 
personal preference - that's the only reason behind that change.


> > -				if(rc != 0)
> > +				if (rc != 0)
> 
> see above
> 
Yup, see above :)


> > -static void reset_resume_key(struct file * dir_file, 
> > -				unsigned char * filename, 
> > -				unsigned int len,int Unicode,struct nls_table * nls_tab) {
> > +static void 
> > +reset_resume_key(struct file *dir_file, unsigned char *filename,
> > +		 unsigned int len, int Unicode, struct nls_table *nls_tab)
> > +{
> 
> Lex Linus?  Either way you don't stay within the 80 column.
> 
Whoops, my bad, I intended to.


> > -				(FILE_DIRECTORY_INFO *) ((char *) pfindData + 
> > +				(FILE_DIRECTORY_INFO *)((char *) pfindData + 
> >  					le16_to_cpu(findParms.LastNameOffset));
> 
> Nasty casting.  In most cases I fixed similar code by creating a
> helper inline function with a proper name.  Requires some care,
> though.
> 
Sepperate issue, sepperate patch.


> 
> Rest looks fine to me.  Since it's Steve's code, treat this as some
> random opinion only.  Cleanups should make the code more maintainable
> and whoever is the maintainer defines what that means.
> 
Ofcourse. It's all up to Steve.


> Still, a pile of nice work.  Thanks.
> 
Thank you.


-- 
Jesper


