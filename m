Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131169AbRACDTu>; Tue, 2 Jan 2001 22:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132148AbRACDTl>; Tue, 2 Jan 2001 22:19:41 -0500
Received: from mx4.mx.voyager.net ([216.93.66.83]:63759 "EHLO
	mx4.mx.voyager.net") by vger.kernel.org with ESMTP
	id <S132128AbRACDTa>; Tue, 2 Jan 2001 22:19:30 -0500
Message-ID: <3A529304.23E81420@megsinet.net>
Date: Tue, 02 Jan 2001 20:48:36 -0600
From: "M.H.VanLeeuwen" <vanl@megsinet.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-prerelease i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
CC: trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org,
        viro@math.psu.edu
Subject: Again, kernel BUG at /usr/src/linux/include/linux/nfs_fs.h:167!  
 2.4.0-prerelease
In-Reply-To: <3A3BE424.4A7FB8D9@megsinet.net>
		<14909.57536.917716.473278@charged.uio.no> <14909.62565.397454.950907@notabene.cse.unsw.edu.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

I thought I'd seen this same bug on 2.4.0-test12 after I applied your patch
but didn't follow up until now.  sorry.

Anyway, with 2.4.0-prerelease and an updated loop.c.patch, below the ksymoops
output (your patch updated to 2.4.0-prerelease), I got the following BUG reports.

So it appears as if the "obviously correct patch ;-)" doesn't fix this particular
problem, but doesn't seem to break anything obvious.

Later,
Martin

ksymoops 2.3.5 on i686 2.4.0-prerelease.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-prerelease/ (default)
     -m /boot/System.map-2.4.0-prerelease (specified)

activating NMI Watchdog ... done.
cpu: 0, clocks: 680100, slice: 226700
cpu: 1, clocks: 680100, slice: 226700
kernel BUG at /usr/src/linux/include/linux/nfs_fs.h:167!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c015cf61>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 00000039   ebx: c9183e80   ecx: 00000000   edx: 00000002
esi: cb17dcc0   edi: cb1d3d40   ebp: c962e000   esp: c962fd04
ds: 0018   es: 0018   ss: 0018
Process find (pid: 29692, stackpage=c962f000)
Stack: c022fea5 c0230040 000000a7 cabe30c0 c89c9860 00000000 c12c8294 c015bf1d
       cabe30c0 c89c9860 c12c8294 00000000 00001000 c89c9860 ffffffff c12c8294
       cabe30c0 fffffff4 c015c721 cabe30c0 c89c9860 c12c8294 cabe30c0 c12c8294
Call Trace: [<c022fea5>] [<c0230040>] [<c015bf1d>] [<c015c721>] [<c0125bf7>] [<c018b15c>] [<c018b064>]
       [<c018b48b>] [<c0181b6f>] [<c0181d03>] [<c0181d6b>] [<c0181ef7>] [<c0152bea>] [<c0151295>] [<c0112e28>]
       [<c0123ff4>] [<c014133c>] [<c014170c>] [<c0141867>] [<c014170c>] [<c0123548>] [<c0108fd3>]
Code: 0f 0b 83 c4 0c 89 7e 1c eb 26 90 8d 74 26 00 6a 00 8b 54 24

>>EIP; c015cf61 <nfs_create_request+195/1e4>   <=====
Trace; c022fea5 <devfsd_buf_size+1b85/10a8c>
Trace; c0230040 <devfsd_buf_size+1d20/10a8c>
Trace; c015bf1d <nfs_readpage_async+13d/1c0>
Trace; c015c721 <nfs_readpage+c5/12c>
Trace; c0125bf7 <do_generic_file_read+347/53c>
Trace; c018b15c <lo_receive+58/68>
Trace; c018b064 <lo_read_actor+0/a0>
Trace; c018b48b <do_lo_request+31f/414>
Trace; c0181b6f <__make_request+5bb/638>
Trace; c0181d03 <generic_make_request+117/124>
Trace; c0181d6b <submit_bh+5b/7c>
Trace; c0181ef7 <ll_rw_block+127/188>
Trace; c0152bea <ext2_bread+ce/110>
Trace; c0151295 <ext2_readdir+91/37c>
Trace; c0112e28 <do_page_fault+0/3e8>
Trace; c0123ff4 <do_munmap+58/250>
Trace; c014133c <vfs_readdir+8c/e8>
Trace; c014170c <filldir64+0/10c>
Trace; c0141867 <sys_getdents64+4f/b8>
Trace; c014170c <filldir64+0/10c>
Trace; c0123548 <sys_brk+b4/d8>
Trace; c0108fd3 <system_call+33/38>
Code;  c015cf61 <nfs_create_request+195/1e4>
00000000 <_EIP>:
Code;  c015cf61 <nfs_create_request+195/1e4>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c015cf63 <nfs_create_request+197/1e4>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c015cf66 <nfs_create_request+19a/1e4>
   5:   89 7e 1c                  mov    %edi,0x1c(%esi)
Code;  c015cf69 <nfs_create_request+19d/1e4>
   8:   eb 26                     jmp    30 <_EIP+0x30> c015cf91 <nfs_create_request+1c5/1e4>
Code;  c015cf6b <nfs_create_request+19f/1e4>
   a:   90                        nop
Code;  c015cf6c <nfs_create_request+1a0/1e4>
   b:   8d 74 26 00               lea    0x0(%esi,1),%esi
Code;  c015cf70 <nfs_create_request+1a4/1e4>
   f:   6a 00                     push   $0x0
Code;  c015cf72 <nfs_create_request+1a6/1e4>
  11:   8b 54 24 00               mov    0x0(%esp,1),%edx

kernel BUG at /usr/src/linux/include/linux/nfs_fs.h:167!
invalid operand: 0000
CPU:    1
EIP:    0010:[<c015cf61>]
EFLAGS: 00010286
eax: 00000039   ebx: c9183e80   ecx: 00000000   edx: 01000000
esi: c87c3ce0   edi: cb1d3d40   ebp: c5f38000   esp: c5f39d2c
ds: 0018   es: 0018   ss: 0018
Process find (pid: 29930, stackpage=c5f39000)
Stack: c022fea5 c0230040 000000a7 cabe3360 c8ad1040 00000000 c115d0d4 c015bf1d
       cabe3360 c8ad1040 c115d0d4 00000000 00001000 c8ad1040 ffffffff c115d0d4
       cabe3360 fffffff4 c015c721 cabe3360 c8ad1040 c115d0d4 cabe3360 c115d0d4
Call Trace: [<c022fea5>] [<c0230040>] [<c015bf1d>] [<c015c721>] [<c0125bf7>] [<c018b15c>] [<c018b064>]
       [<c018b48b>] [<c0181b6f>] [<c0181d03>] [<c0181d6b>] [<c0181ef7>] [<c0151347>] [<c0112e28>] [<c0123ff4>]
       [<c014133c>] [<c014170c>] [<c0141867>] [<c014170c>] [<c0123548>] [<c0108fd3>]
Code: 0f 0b 83 c4 0c 89 7e 1c eb 26 90 8d 74 26 00 6a 00 8b 54 24

>>EIP; c015cf61 <nfs_create_request+195/1e4>   <=====
Trace; c022fea5 <devfsd_buf_size+1b85/10a8c>
Trace; c0230040 <devfsd_buf_size+1d20/10a8c>
Trace; c015bf1d <nfs_readpage_async+13d/1c0>
Trace; c015c721 <nfs_readpage+c5/12c>
Trace; c0125bf7 <do_generic_file_read+347/53c>
Trace; c018b15c <lo_receive+58/68>
Trace; c018b064 <lo_read_actor+0/a0>
Trace; c018b48b <do_lo_request+31f/414>
Trace; c0181b6f <__make_request+5bb/638>
Trace; c0181d03 <generic_make_request+117/124>
Trace; c0181d6b <submit_bh+5b/7c>
Trace; c0181ef7 <ll_rw_block+127/188>
Trace; c0151347 <ext2_readdir+143/37c>
Trace; c0112e28 <do_page_fault+0/3e8>
Trace; c0123ff4 <do_munmap+58/250>
Trace; c014133c <vfs_readdir+8c/e8>
Trace; c014170c <filldir64+0/10c>
Trace; c0141867 <sys_getdents64+4f/b8>
Trace; c014170c <filldir64+0/10c>
Trace; c0123548 <sys_brk+b4/d8>
Trace; c0108fd3 <system_call+33/38>
Code;  c015cf61 <nfs_create_request+195/1e4>
00000000 <_EIP>:
Code;  c015cf61 <nfs_create_request+195/1e4>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c015cf63 <nfs_create_request+197/1e4>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c015cf66 <nfs_create_request+19a/1e4>
   5:   89 7e 1c                  mov    %edi,0x1c(%esi)
Code;  c015cf69 <nfs_create_request+19d/1e4>
   8:   eb 26                     jmp    30 <_EIP+0x30> c015cf91 <nfs_create_request+1c5/1e4>
Code;  c015cf6b <nfs_create_request+19f/1e4>
   a:   90                        nop
Code;  c015cf6c <nfs_create_request+1a0/1e4>
   b:   8d 74 26 00               lea    0x0(%esi,1),%esi
Code;  c015cf70 <nfs_create_request+1a4/1e4>
   f:   6a 00                     push   $0x0
Code;  c015cf72 <nfs_create_request+1a6/1e4>
  11:   8b 54 24 00               mov    0x0(%esp,1),%edx


updated patch for 2.4.0-prerelease
__________________________________

--- loop.c.orig Fri Dec 29 16:07:21 2000
+++ loop.c      Tue Jan  2 17:11:38 2001
@@ -441,37 +441,18 @@
                if (!aops->prepare_write || !aops->commit_write)
                        lo->lo_flags |= LO_FLAGS_READ_ONLY;

-               error = get_write_access(inode);
-               if (error)
-                       goto out_putf;
 
                /* Backed by a regular file - we need to hold onto a file
-                  structure for this file.  Friggin' NFS can't live without
-                  it on write and for reading we use do_generic_file_read(),
-                  so...  We create a new file structure based on the one
-                  passed to us via 'arg'.  This is to avoid changing the file
-                  structure that the caller is using */
+                  structure for this file.  There is no reliable way to
+                  copy it (due to a filesys private field that may be ref-count
ed)
+                  so we just keep the reference to the file like a "dup" would.
+                */
 
                lo->lo_device = inode->i_dev;
                lo->lo_flags |= LO_FLAGS_DO_BMAP;
 
-               error = -ENFILE;
-               lo->lo_backing_file = get_empty_filp();
-               if (lo->lo_backing_file == NULL) {
-                       put_write_access(inode);
-                       goto out_putf;
-               }
-
-               lo->lo_backing_file->f_mode = file->f_mode;
-               lo->lo_backing_file->f_pos = file->f_pos;
-               lo->lo_backing_file->f_flags = file->f_flags;
-               lo->lo_backing_file->f_owner = file->f_owner;
-               lo->lo_backing_file->f_dentry = file->f_dentry;
-               lo->lo_backing_file->f_vfsmnt = mntget(file->f_vfsmnt);
-               lo->lo_backing_file->f_op = fops_get(file->f_op);
-               lo->lo_backing_file->private_data = file->private_data;
-               file_moveto(lo->lo_backing_file, file);
-
+               lo->lo_backing_file = file;
+               get_file(file);
                error = 0;
        }
 
@@ -539,8 +520,6 @@
 
        if (lo->lo_backing_file != NULL) {
                struct file *filp = lo->lo_backing_file;
-               if ((filp->f_mode & FMODE_WRITE) == 0)
-                       put_write_access(filp->f_dentry->d_inode);
                fput(filp);
                lo->lo_backing_file = NULL;
        } else {

--------------------------------------------------------------------------------------------
Neil Brown wrote:
> 
> On Monday December 18, trond.myklebust@fys.uio.no wrote:
> > >>>>> " " == M H VanLeeuwen <vanl@megsinet.net> writes:
> >
> >      > Trond, Neil I don't know if this is a loopback bug or an NFS
> >      > bug but since nfs_fs.h was implicated so I thought one of you
> >      > may be interested.
> >
> >      > Could you let me know if you know this problem has already been
> >      > fixed or if you need more info.
> >
> > Hi,
> >
> > As far as I'm concerned, it's a loopback bug.
> 
> I read it the same way.
> Actually, I cannot see the point of copying the "struct file"!  Why
> not just take a reference to it?  The comment tries to justify it, but
> I don't buy it.
> 
> Would you mind trying the following patch (totally untested, but
> obviously correct :-)
> 
> NeilBrown
> 
> --- drivers/block/loop.c        2000/12/18 10:25:22     1.1
> +++ drivers/block/loop.c        2000/12/18 11:23:52
> @@ -441,37 +441,18 @@
>                 if (!aops->prepare_write || !aops->commit_write)
>                         lo->lo_flags |= LO_FLAGS_READ_ONLY;
> 
> -               error = get_write_access(inode);
> -               if (error)
> -                       goto out_putf;
> 
>                 /* Backed by a regular file - we need to hold onto a file
> -                  structure for this file.  Friggin' NFS can't live without
> -                  it on write and for reading we use do_generic_file_read(),
> -                  so...  We create a new file structure based on the one
> -                  passed to us via 'arg'.  This is to avoid changing the file
> -                  structure that the caller is using */
> +                  structure for this file.  There is no reliable way to
> +                  copy it (due to a filesys private field that may be ref-counted)
> +                  so we just keep a reference to the file like a "dup" would.
> +               */
> 
>                 lo->lo_device = inode->i_dev;
>                 lo->lo_flags = LO_FLAGS_DO_BMAP;
> 
> -               error = -ENFILE;
> -               lo->lo_backing_file = get_empty_filp();
> -               if (lo->lo_backing_file == NULL) {
> -                       put_write_access(inode);
> -                       goto out_putf;
> -               }
> -
> -               lo->lo_backing_file->f_mode = file->f_mode;
> -               lo->lo_backing_file->f_pos = file->f_pos;
> -               lo->lo_backing_file->f_flags = file->f_flags;
> -               lo->lo_backing_file->f_owner = file->f_owner;
> -               lo->lo_backing_file->f_dentry = file->f_dentry;
> -               lo->lo_backing_file->f_vfsmnt = mntget(file->f_vfsmnt);
> -               lo->lo_backing_file->f_op = fops_get(file->f_op);
> -               lo->lo_backing_file->private_data = file->private_data;
> -               file_moveto(lo->lo_backing_file, file);
> -
> +               lo->lo_backing_file = file;
> +               get_file(file);
>                 error = 0;
>         }
> 
> @@ -539,8 +520,6 @@
> 
>         if (lo->lo_backing_file != NULL) {
>                 struct file *filp = lo->lo_backing_file;
> -               if ((filp->f_mode & FMODE_WRITE) == 0)
> -                       put_write_access(filp->f_dentry->d_inode);
>                 fput(filp);
>                 lo->lo_backing_file = NULL;
>         } else {
> 
> >
> > Somebody appears to be trying to copy a 'struct file' in the routine
> > 'loop_set_fd'. This will cause havoc in any and all filesystems that
> > rely on f_ops->open() , f_ops->release() to maintain internal data.
> > In this case, it's the file's RPC authorizations, that are getting
> > garbage-collected from beneath you once the original struct file gets
> > fput() at the end of the routine.
> >
> > Cheers,
> >   Trond
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
