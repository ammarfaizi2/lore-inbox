Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261293AbUL2B7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261293AbUL2B7K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 20:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbUL2B7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 20:59:10 -0500
Received: from mail.fh-wedel.de ([213.39.232.198]:47039 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261293AbUL2B52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 20:57:28 -0500
Date: Wed, 29 Dec 2004 02:57:16 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Steve French <sfrench@samba.org>,
       Steve French <sfrench@us.ibm.com>,
       samba-technical <samba-technical@lists.samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2/3] whitespace cleanups in fs/cifs/file.c
Message-ID: <20041229015716.GB29323@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.61.0412270019370.3552@dragon.hygekrogen.localhost> <1104104286.16545.7.camel@localhost.localdomain> <Pine.LNX.4.61.0412290048150.3528@dragon.hygekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.61.0412290048150.3528@dragon.hygekrogen.localhost>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 December 2004 00:52:32 +0100, Jesper Juhl wrote:
> 
> The style used in fs/cifs/file.c is not very consistent and (to me at 
> least) seems to diverge a bit from CodingStyle and there's some 
> whitespace damage in there as well.
> This patch attempts to make the style a bit more consistent and readable 
> and tries to clean up the whitespace damage. 
> The patch is cut on top of my copy_to_user fix patch that was just posted 
> a few minutes ago.
> This patch makes no actual code changes.
> 
> 
> -	struct list_head * tmp;
> +	struct list_head *tmp;

Lindent prefers the old variant, I prefer the new one.  Steve?

> -	FILE_ALL_INFO * buf = NULL;
> +	FILE_ALL_INFO *buf = NULL;

dito

> -		if(file->private_data != NULL) {
> +		if (file->private_data != NULL) {

		if (file->private_data) {

It's a question of taste, but in most cases I consider the shorter
version to be more obvious.

> -	if(full_path == NULL) {
> +	if (full_path == NULL) {

	if (!full_path) {

> -	buf = kmalloc(sizeof(FILE_ALL_INFO),GFP_KERNEL);
> -	if(buf== NULL) {
> +	buf = kmalloc(sizeof(FILE_ALL_INFO), GFP_KERNEL);
> +	if (buf== NULL) {

	if (!buf) {

>  		if (full_path)
>  			kfree(full_path);

		kfree(full_path);

kfree(NULL) works just fine, and for a very good reason.

> -static int cifs_relock_file(struct cifsFileInfo * cifsFile)
> +static int 
> +cifs_relock_file(struct cifsFileInfo *cifsFile)

Linus viciously prefers to keep return type and function name on a
single line.  I cannot quite follow his reasoning, but would leave
that part out, unless explicitly requested by Steve.

> -static int cifs_reopen_file(struct inode *inode, struct file *file, int can_flush)
> +static int 
> +cifs_reopen_file(struct inode *inode, struct file *file, int can_flush)

Dito, except that the old code blew the 80 column limit.  In such a
case I don't mind p***ing Linus off.  The small things that make you
smile once in a while. ;)

> -	if(file->f_dentry == NULL) {
> +	if (file->f_dentry == NULL) {

	if (!file->f_dentry) {

> -	if(full_path == NULL) {
> +	if (full_path == NULL) {

	if (!full_path) {

> -/*	buf = kmalloc(sizeof(FILE_ALL_INFO),GFP_KERNEL);
> -	if(buf==0) {
> +/*	buf = kmalloc(sizeof(FILE_ALL_INFO), GFP_KERNEL);
> +	if (buf==0) {

Commented out?  Oh well, doesn't hurt either way.

> @@ -408,7 +410,7 @@ cifs_close(struct inode *inode, struct f
>  	struct cifs_sb_info *cifs_sb;
>  	struct cifsTconInfo *pTcon;
>  	struct cifsFileInfo *pSMBFile =
> -		(struct cifsFileInfo *) file->private_data;
> +		(struct cifsFileInfo *)file->private_data;

	struct cifsFileInfo *pSMBFile = file->private_data;

Casting a typeless pointer is pointless.

>  	struct cifsFileInfo *pCFileStruct =
> -	    (struct cifsFileInfo *) file->private_data;
> -	char * ptmp;
> +	    (struct cifsFileInfo *)file->private_data;
> +	char *ptmp;

dito

> @@ -563,7 +565,7 @@ cifs_lock(struct file *file, int cmd, st
>  
>  	if (IS_GETLK(cmd)) {
>  		rc = CIFSSMBLock(xid, pTcon,
> -				 ((struct cifsFileInfo *) file->
> +				 ((struct cifsFileInfo *)file->
>  				  private_data)->netfid,
>  				 length,
>  				 pfLock->fl_start, 0, 1, lockType,

dito
Well, not really.  Imo, below code or something similar is much nicer
and the extra variable is a small expense for it.

	if (IS_GETLK(cmd)) {
		struct cifsFileInfo *cifs_fi = file->private_data;
		rc = CIFSSMBLock(xid, pTcon, cifs_fi->netfid, ...

> -	if(file->f_dentry == NULL)
> +	if (file->f_dentry == NULL)

see above

> -	if(cifs_sb == NULL) {
> +	if (cifs_sb == NULL) {

dito

> -		while(rc == -EAGAIN) {
> -			if(file->private_data == NULL) {
> +		while (rc == -EAGAIN) {
> +			if (file->private_data == NULL) {

dito

> -				if((file->f_dentry == NULL) ||
> +				if ((file->f_dentry == NULL) ||

dito

> -	if(file->f_dentry) {
> -		if(file->f_dentry->d_inode) {
> +	if (file->f_dentry) {
> +		if (file->f_dentry->d_inode) {

	if (file->f_dentry && file->f_dentry->d_inode) {

There is too little context to see if this conversion is possible.
And I'm too lazy to check myself.

> -	if(file->f_dentry == NULL)
> +	if (file->f_dentry == NULL)

see above

> -	if(cifs_sb == NULL) {
> +	if (cifs_sb == NULL) {

dito

> -		open_file = (struct cifsFileInfo *) file->private_data;
> +		open_file = (struct cifsFileInfo *)file->private_data;

see above

> -	if(file->f_dentry->d_inode == NULL) {
> +	if (file->f_dentry->d_inode == NULL) {

see above

> -		while(rc == -EAGAIN) {
> -			if(file->private_data == NULL) {
> +		while (rc == -EAGAIN) {
> +			if (file->private_data == NULL) {

dito

> -				if((file->f_dentry == NULL) ||
> +				if ((file->f_dentry == NULL) ||

dito

> -		} else
> +		} else {
>  			*poffset += bytes_written;
> +		}

Don't.  The extra brackets only cost extra lines on your display.
Most people are unaware of it, but the square-inch of display area is
the single most expensive part of most workstations.  Don't waste it.

> -	if(file->f_dentry) {
> -		if(file->f_dentry->d_inode) {
> +	if (file->f_dentry) {
> +		if (file->f_dentry->d_inode) {

see above

> -		if(tmp->next == NULL) {
> -			cFYI(1,("File instance %p removed",tmp));
> +		if (tmp->next == NULL) {
> +			cFYI(1, ("File instance %p removed", tmp));

see above

> -	if(open_file == NULL) {
> -		cFYI(1,("No writeable filehandles for inode"));
> +	if (open_file == NULL) {
> +		cFYI(1, ("No writeable filehandles for inode"));

dito

> -		rc = cifs_write(file, page_data+offset,to-offset,
> +		rc = cifs_write(file, page_data+offset, to-offset,
>                                          &position);

Combining those two lines should still be within the 80 column budget.

> -	if(rc == 0)
> +	if (rc == 0)

	if (!rc)

Ok, in this case I prefer the explicit comparision.  But for
completeness, maybe Steve disagrees.

> -int cifs_flush(struct file *file)
> +int 
> +cifs_flush(struct file *file)

Lex Linus?

> -				if(rc != 0)
> +				if (rc != 0)

see above

> -				if(rc != 0)
> +				if (rc != 0)

dito

> -int cifs_file_mmap(struct file * file, struct vm_area_struct * vma)
> +int 
> +cifs_file_mmap(struct file *file, struct vm_area_struct *vma)

Lex Linus?

> -static void cifs_copy_cache_pages(struct address_space *mapping, 
> -		struct list_head *pages, int bytes_read, 
> -		char *data,struct pagevec * plru_pvec)
> +static void
> +cifs_copy_cache_pages(struct address_space *mapping, struct list_head *pages,
> +		      int bytes_read, char *data, struct pagevec *plru_pvec)

dito

> -			memset(target+bytes_read,0,PAGE_CACHE_SIZE-bytes_read);
> +			memset(target + bytes_read, 0, PAGE_CACHE_SIZE - bytes_read);
				     ^ ^			      ^ ^
I'd remove those four spaces again.  It's very personal, agreed.  Imo,
the arithmetic operators and the commmata have different precedence on
the semantical level, so it helps me to have different syntax here as
well.  But surely many people will disagree and most Just Don't
Care(tm).

> -				if(rc != 0)
> +				if (rc != 0)

see above

> -static int cifs_readpage_worker(struct file *file, struct page *page, loff_t * poffset)
> +static int 
> +cifs_readpage_worker(struct file *file, struct page *page, loff_t *poffset)

Well done.  Sometimes you need to be a bastard. ;)

> -int is_size_safe_to_change(struct cifsInodeInfo * cifsInode)
> +int 
> +is_size_safe_to_change(struct cifsInodeInfo *cifsInode)

Lex Linus?

> -	if(cifsInode == NULL)
> +	if (cifsInode == NULL)

see above

> -		open_file = list_entry(tmp,struct cifsFileInfo, flist);
> -		if(open_file == NULL)
> +		open_file = list_entry(tmp, struct cifsFileInfo, flist);
> +		if (open_file == NULL)

dito

> -		if(tmp->next == NULL) {
> -			cFYI(1,("File instance %p removed",tmp));
> +		if (tmp->next == NULL) {
> +			cFYI(1, ("File instance %p removed", tmp));

dito

> -		if(*ptmp_inode == NULL) {
> +		if (*ptmp_inode == NULL) {

dito

> -			if(*ptmp_inode == NULL)
> +			if (*ptmp_inode == NULL)

dito

> -		if(tmp_dentry == NULL) {
> -			cERROR(1,("Failed allocating dentry"));
> +		if (tmp_dentry == NULL) {
> +			cERROR(1, ("Failed allocating dentry"));

dito

> -		if(*ptmp_inode == NULL)
> +		if (*ptmp_inode == NULL)

dito

> -static void reset_resume_key(struct file * dir_file, 
> -				unsigned char * filename, 
> -				unsigned int len,int Unicode,struct nls_table * nls_tab) {
> +static void 
> +reset_resume_key(struct file *dir_file, unsigned char *filename,
> +		 unsigned int len, int Unicode, struct nls_table *nls_tab)
> +{

Lex Linus?  Either way you don't stay within the 80 column.

> -	if((tmp_inode == NULL) || (tmp_dentry == NULL)) {
> +	if ((tmp_inode == NULL) || (tmp_dentry == NULL)) {

see above

> -	if((tmp_inode == NULL) || (tmp_dentry == NULL)) {
> +	if ((tmp_inode == NULL) || (tmp_dentry == NULL)) {

dito

> -	if(file->f_dentry == NULL) {
> +	if (file->f_dentry == NULL) {

dito

> -	if(full_path == NULL) {
> +	if (full_path == NULL) {

dito

>  		if (file->private_data != NULL) {

dito

>  			cifsFile =
> -				(struct cifsFileInfo *) file->private_data;
> +				(struct cifsFileInfo *)file->private_data;

see above

> -			if(file->private_data == NULL)
> +			if (file->private_data == NULL)

see above

>  			lastFindData = 
> -				(FILE_DIRECTORY_INFO *) ((char *) pfindData + 
> +				(FILE_DIRECTORY_INFO *)((char *) pfindData + 
>  					le16_to_cpu(findParms.LastNameOffset));

Nasty casting.  In most cases I fixed similar code by creating a
helper inline function with a proper name.  Requires some care,
though.

> -				if(cifsFile->search_resume_name == NULL) {
> +				if (cifsFile->search_resume_name == NULL) {

see above

> -				if(cifsFile->search_resume_name == NULL) {
> +				if (cifsFile->search_resume_name == NULL) {

dito

> -					if(cifsFile->search_resume_name == NULL) {
> +					if (cifsFile->search_resume_name == NULL) {

dito

> -					if(cifsFile->search_resume_name == NULL) {
> +					if (cifsFile->search_resume_name == NULL) {

dito

>  		kfree(data);
>  	if (full_path)
>  		kfree(full_path);

	kfree(full_path);

Looks like you can do the same above as well.

> -int cifs_prepare_write(struct file *file, struct page *page,
> -			unsigned from, unsigned to)
> +
> +int 
> +cifs_prepare_write(struct file *file, struct page *page, unsigned from, 
> +		   unsigned to)

Lex Linus?


Rest looks fine to me.  Since it's Steve's code, treat this as some
random opinion only.  Cleanups should make the code more maintainable
and whoever is the maintainer defines what that means.

Still, a pile of nice work.  Thanks.

Jörn

-- 
All art is but imitation of nature.
-- Lucius Annaeus Seneca
