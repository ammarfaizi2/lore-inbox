Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131066AbRCGNmn>; Wed, 7 Mar 2001 08:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131071AbRCGNme>; Wed, 7 Mar 2001 08:42:34 -0500
Received: from [217.5.141.103] ([217.5.141.103]:42864 "EHLO hera.lion-ag.de")
	by vger.kernel.org with ESMTP id <S131066AbRCGNmQ>;
	Wed, 7 Mar 2001 08:42:16 -0500
Message-ID: <3AA63A2D.F723FA61@lionbioscience.com>
Date: Wed, 07 Mar 2001 14:39:57 +0100
From: Andreas Helke <andreas.helke@lionbioscience.com>
Organization: LION Bioscience AG
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, nfs@sourceforge.net
CC: sg_info@lionbioscience.com, kirschh@lionbioscienc.com
Subject: :Redhat [Bug 30944] - Kernel 2.4.0 and Kernel 2.2.18: with some programs 
 one file of each directory of NFS shares served by Irix 6.5.9f (and Irix 
 6.5.8) is missing in directory listings
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel 2.4 and Kernel 2.2.18: with some programs one file of each
directory of NFS shares served by Irix 6.5.9f (and Irix 6.5.8) is
missing in directory listings.

We first noted missing directory entries when we put an unmodified
2.2.18 kernel on a Redhat 6.2 system. 

This was done to fight other NFS problems not yet reported by me. With
the Redhat 2.2.14 kernel the computer would completely freeze when we
tried to copy a few hundred MBytes of data from our SGI O2000 file
server from an NFS share mounted with TCP - We "fixed" this problem by
rewriting our NIS automounter maps to allow Linux clients to use UDP.

Unfortunately the missing files in directory listings from SGI Irix
6.5.9f NFS servers still persists with the  2.4 kernel - we used the
kernel 2.4.0 kernel that came with the Redhat 7.1beta
uname -a tells Linux test-ah1 2.4.0-0.99.11 #1 Wed Jan 24 16:07:17 EST
2001 i686 unknown

 
The details of my testing can be found in the following bug report to
Redhat.

bugzilla@redhat.com wrote:
> 
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=30944
> 
> --- shadow/30944        Wed Mar  7 08:19:33 2001
> +++ shadow/30944.tmp.32126      Wed Mar  7 08:19:34 2001
> @@ -0,0 +1,213 @@
> +Bug#: 30944
> +Product: Red Hat Public Beta
> +Version: fisher
> +Platform: i386
> +OS/Version: Linux
> +Status: NEW
> +Resolution:
> +Severity: normal
> +Priority: normal
> +Component: kernel
> +AssignedTo: johnsonm@redhat.com
> +ReportedBy: andreas.helke@lionbioscience.com
> +QAContact: borgan@redhat.com
> +URL:
> +Summary: Kernel 2.4: with some programs one file of each directory of NFS shares served by Irix 6.5.9f (and Irix 6.5.8) is missing in directory listings
> +
> +From Bugzilla Helper:
> +User-Agent: Mozilla/4.72 [en] (X11; I; Linux 2.2.16 i686)
> +
> +
> +With some programs one file per directory is missing in directory listings
> +in NFS shares served by SGI Irix 6.5.9f - With Redhat 7.1 echo *  in a
> +tcshell is one of the programs affected by this bug - Trond Myklebust has
> +an experimental patch for this bug
> +
> +Reproducible: Always
> +Steps to Reproduce:
> +1.Use an NFS server running with SGI Irix 6.5.x  - I tested with 6.5.9f
> +(NFS V3 udp
> +/proc/mounts shows
> +nfsserver:/mnt/links/projectspace/bi/TextMining /projects/bi/TextMining nfs
> +rw,nosuid,v3,rsize=32768,wsize=32768,hard,udp,lock,addr=nfsserver 0 0
> +
> +2.run /home/helke/bin/ls -lR > ls-2.4  (ls is Suse 6.1 Glibc 2.0 binary -
> +(GNU fileutils) 3.16 - Redhat 7.1beta has ls Version (GNU fileutils) 4.0.36
> +)
> +3.compare with the equivalent listing of a computer with Redhat 6.2
> +
> +
> +An alternative way to demonstrate the problem:
> +tcsh
> +cd /projects/bi/TextMining/tmp
> +ls
> +echo *
> +
> +
> +Actual Results:  In every directory one file is missing when using the 2.4
> +kernel
> +
> +7.1beta /bin/ls and echo * in a bash shell show
> +sas-hotfixes srsdo.log
> +Suse 6.1 ls and 7.1beta echo * in a tsch shell show
> +srsdo.log
> +
> +Expected Results:  I4d like to see all files that exist in each directory
> +
> +Not all possible programs trigger this bug. The 7.1 ls shows all files,
> +with Suse 6.1 ls one filer per directory is missing, with echo * in a tcsh
> +shell one file per directory is missing
> +
> +This seems to be a known bug. Linux NFS developer Trond Myklebust has an
> +experimental patch for 2.4.2 I did not yet test this patch.
> +
> +http://www.fys.uio.no/~trondmy/src/2.4.2/
> +
> +NFS client patches for Linux 2.4.2
> +
> +A brief explanation of the patches in this directory
> +
> +linux-2.4.2-dir.dif:
> +
> +An experimental patch for fixing a problem that is due to NFSv(2|3)
> +readdir returning (32|64) bit unsigned offsets.
> +
> +If you are seeing problems involving files that mysteriously disappear
> +from your directory listings, then please consider applying this patch.
> +
> +NOTE: this patch should no longer require any extra patching to glibc.
> +Here follows Trond  Myklebust patch for this probelem on the 2.4.2 kernel
> +
> +
> +http://www.fys.uio.no/~trondmy/src/2.4.2/linux-2.4.2-dir.dif
> +
> +
> +diff -u --recursive --new-file linux-2.4.2-fh_align/fs/nfs/dir.c
> +linux-2.4.2-dir/fs/nfs/dir.c
> +--- linux-2.4.2-fh_align/fs/nfs/dir.c   Fri Feb  9 20:29:44 2001
> ++++ linux-2.4.2-dir/fs/nfs/dir.c        Thu Feb 22 12:34:41 2001
> +@@ -34,6 +34,7 @@
> + #define NFS_PARANOIA 1
> + /* #define NFS_DEBUG_VERBOSE 1 */
> +
> ++static loff_t nfs_dir_llseek(struct file *, loff_t, int);
> + static int nfs_readdir(struct file *, void *, filldir_t);
> + static struct dentry *nfs_lookup(struct inode *, struct dentry *);
> + static int nfs_create(struct inode *, struct dentry *, int);
> +@@ -47,6 +48,7 @@
> +                      struct inode *, struct dentry *);
> +
> + struct file_operations nfs_dir_operations = {
> ++       llseek:         nfs_dir_llseek,
> +        read:           generic_read_dir,
> +        readdir:        nfs_readdir,
> +        open:           nfs_open,
> +@@ -67,6 +69,25 @@
> +        revalidate:     nfs_revalidate,
> +        setattr:        nfs_notify_change,
> + };
> ++
> ++static loff_t nfs_dir_llseek(struct file *file, loff_t offset, int origin)
> ++{
> ++       switch (origin) {
> ++               case 1:
> ++                       if (offset == 0) {
> ++                               offset = file->f_pos;
> ++                               break;
> ++                       }
> ++               case 2:
> ++                       return -EINVAL;
> ++       }
> ++       if (offset != file->f_pos) {
> ++               file->f_pos = offset;
> ++               file->f_reada = 0;
> ++               file->f_version = ++event;
> ++       }
> ++       return (offset <= 0) ? 0 : offset;
> ++}
> +
> + typedef u32 * (*decode_dirent_t)(u32 *, struct nfs_entry *, int);
> + typedef struct {
> +diff -u --recursive --new-file linux-2.4.2-fh_align/fs/nfs/nfs2xdr.c
> +linux-2.4.2-dir/fs/nfs/nfs2xdr.c
> +--- linux-2.4.2-fh_align/fs/nfs/nfs2xdr.c       Fri Feb  9 20:29:44 2001
> ++++ linux-2.4.2-dir/fs/nfs/nfs2xdr.c    Thu Feb 22 10:47:49 2001
> +@@ -419,7 +419,7 @@
> +                bufsiz = bufsiz >> 2;
> +
> +        p = xdr_encode_fhandle(p, args->fh);
> +-       *p++ = htonl(args->cookie);
> ++       *p++ = htonl(args->cookie & 0xFFFFFFFF);
> +        *p++ = htonl(bufsiz); /* see above */
> +        req->rq_slen = xdr_adjust_iovec(req->rq_svec, p);
> +
> +@@ -504,7 +504,7 @@
> +        entry->name       = (const char *) p;
> +        p                += XDR_QUADLEN(entry->len);
> +        entry->prev_cookie        = entry->cookie;
> +-       entry->cookie     = ntohl(*p++);
> ++       entry->cookie     = (s64)((off_t)ntohl(*p++));
> +        entry->eof        = !p[0] && p[1];
> +
> +        return p;
> +diff -u --recursive --new-file linux-2.4.2-fh_align/fs/nfs/nfs3xdr.c
> +linux-2.4.2-dir/fs/nfs/nfs3xdr.c
> +--- linux-2.4.2-fh_align/fs/nfs/nfs3xdr.c       Fri Feb  9 20:29:44 2001
> ++++ linux-2.4.2-dir/fs/nfs/nfs3xdr.c    Thu Feb 22 10:47:49 2001
> +@@ -523,6 +523,13 @@
> +        return 0;
> + }
> +
> ++/* Hack to sign-extending 32-bit cookies */
> ++static inline
> ++u64 nfs_transform_cookie64(u64 cookie)
> ++{
> ++       return (cookie & 0x80000000) ? (cookie ^ 0xFFFFFFFF00000000) :
> +cookie;
> ++}
> ++
> + /*
> +  * Encode arguments to readdir call
> +  */
> +@@ -533,7 +540,7 @@
> +        int             buflen, replen;
> +
> +        p = xdr_encode_fhandle(p, args->fh);
> +-       p = xdr_encode_hyper(p, args->cookie);
> ++       p = xdr_encode_hyper(p, nfs_transform_cookie64(args->cookie));
> +        *p++ = args->verf[0];
> +        *p++ = args->verf[1];
> +        if (args->plus) {
> +@@ -635,6 +642,7 @@
> + nfs3_decode_dirent(u32 *p, struct nfs_entry *entry, int plus)
> + {
> +        struct nfs_entry old = *entry;
> ++       u64 cookie;
> +
> +        if (!*p++) {
> +                if (!*p)
> +@@ -648,7 +656,8 @@
> +        entry->name = (const char *) p;
> +        p += XDR_QUADLEN(entry->len);
> +        entry->prev_cookie = entry->cookie;
> +-       p = xdr_decode_hyper(p, &entry->cookie);
> ++       p = xdr_decode_hyper(p, &cookie);
> ++       entry->cookie = nfs_transform_cookie64(cookie);
> +
> +        if (plus) {
> +                p = xdr_decode_post_op_attr(p, &entry->fattr);
> +diff -u --recursive --new-file linux-2.4.2-fh_align/fs/readdir.c
> +linux-2.4.2-dir/fs/readdir.c
> +--- linux-2.4.2-fh_align/fs/readdir.c   Mon Dec 11 22:45:42 2000
> ++++ linux-2.4.2-dir/fs/readdir.c        Thu Feb 22 10:47:49 2001
> +@@ -315,7 +315,8 @@
> +        lastdirent = buf.previous;
> +        if (lastdirent) {
> +                struct linux_dirent64 d;
> +-               d.d_off = file->f_pos;
> ++               /* get the sign extension right */
> ++               d.d_off = (off_t)file->f_pos;
> +                copy_to_user(&lastdirent->d_off, &d.d_off,
> +sizeof(d.d_off));
> +                error = count - buf.count;
> +        }
> 
> Please do not reply directly to this email. All additional
> comments should be made in the comments box of this bug report.

Andreas
-- 
Andreas Helke
LION Bioscience AG, Waldhofer Strasse 98, D-69123 Heidelberg
Voice +49-6221-4038-245, Fax +49-6221-4038-460
mailto:andreas.helke@lionbioscience.com, http://www.lionbioscience.com
