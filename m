Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932331AbVKUPuo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbVKUPuo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 10:50:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932334AbVKUPuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 10:50:44 -0500
Received: from xproxy.gmail.com ([66.249.82.196]:35275 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932331AbVKUPun convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 10:50:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=W6Hxzk6jnSt1Vk4EefjaGICM/U90/OyywgvpUG75yKkJlvp+kWj/ZFzNcTrWlCizZjom3ng8nxILNo0rShIdOXMmiJWEo/7n0YdxJZrKgPTQwRK8CidPX5yBfELZyCsxye0D2iv0anDPM2WX3KghmJmONrVZZ3Tk3Kdns5V/Lvk=
Message-ID: <afcef88a0511210750g29b0431fwb871f5d1a30649a1@mail.gmail.com>
Date: Mon, 21 Nov 2005 09:50:41 -0600
From: Michael Thompson <michael.craig.thompson@gmail.com>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [PATCH 5/12: eCryptfs] Header declarations
Cc: Phillip Hellewell <phillip@hellewell.homeip.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@ftp.linux.org.uk, mike@halcrow.us, mhalcrow@us.ibm.com,
       mcthomps@us.ibm.com, yoder1@us.ibm.com
In-Reply-To: <84144f020511190237w8b5404em461bb2eaf5fa8ea6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051119041130.GA15559@sshock.rn.byu.edu>
	 <20051119041837.GE15747@sshock.rn.byu.edu>
	 <84144f020511190237w8b5404em461bb2eaf5fa8ea6@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/05, Pekka Enberg <penberg@cs.helsinki.fi> wrote:
> Hi Phillip,
>
> On 11/19/05, Phillip Hellewell <phillip@hellewell.homeip.net> wrote:
> > +struct ecryptfs_session_key {
> > +#define ECRYPTFS_USERSPACE_SHOULD_TRY_TO_DECRYPT 0x01
> > +#define ECRYPTFS_USERSPACE_SHOULD_TRY_TO_ENCRYPT 0x02
> > +#define ECRYPTFS_CONTAINS_DECRYPTED_KEY 0x04
> > +#define ECRYPTFS_CONTAINS_ENCRYPTED_KEY 0x08
> > +       int32_t flags;
> > +       int32_t encrypted_key_size;
> > +       int32_t decrypted_key_size;
> > +       uint8_t decrypted_key[ECRYPTFS_MAX_KEY_BYTES];
> > +       uint8_t encrypted_key[ECRYPTFS_MAX_ENCRYPTED_KEY_BYTES];
>
> s32 and u8 are preferred in the kernel.

Thanks for that, lots of little things like this were undoubtably
missed, we use u/s# in other areas. Changed and will be resent after
all comments are in.

>
> > +#define OBSERVE_ASSERTS 1
> > +#ifdef OBSERVE_ASSERTS
> > +#define ASSERT(EX)                                                           \
> > +do {                                                                         \
> > +        if (unlikely(!(EX))) {                                                \
> > +               printk(KERN_CRIT "ASSERTION FAILED: %s at %s:%d (%s)\n", #EX, \
> > +                      __FILE__, __LINE__, __FUNCTION__);                     \
> > +                BUG();                                                        \
> > +        }                                                                    \
> > +} while (0)
> > +#else
> > +#define ASSERT(EX) ;
> > +#endif                         /* OBSERVE_ASSERTS */
>
> Any reason why you can't just use BUG and BUG_ON()?

No reason? I think we've had this comment before, not sure if we have
had a decent reason though... let me see if I can find out why we do
it this way.

> > +
> > +/**
> > + * Halcrow: What does the kernel VFS do to ensure that there is no
> > + * contention for file->private_data?
> > + */
>
> Please elaborate?

I believe this is an old and lingering comment. While I don't know who
originated, it sounds like a question to Michael Halcrow regarding
locking of a struct file's private data... It will be removed for next
submission.

>
> > +#define ECRYPTFS_FILE_TO_PRIVATE(file) ((struct ecryptfs_file_info *) \
> > +                                        ((file)->private_data))
> > +#define ECRYPTFS_FILE_TO_PRIVATE_SM(file) ((file)->private_data)
> > +#define ECRYPTFS_FILE_TO_LOWER(file) \
> > +        ((ECRYPTFS_FILE_TO_PRIVATE(file))->wfi_file)
> > +#define ECRYPTFS_INODE_TO_PRIVATE(ino) ((struct ecryptfs_inode_info *) \
> > +                                        (ino)->u.generic_ip)
> > +#define ECRYPTFS_INODE_TO_PRIVATE_SM(ino) ((ino)->u.generic_ip)
> > +#define ECRYPTFS_INODE_TO_LOWER(ino) (ECRYPTFS_INODE_TO_PRIVATE(ino)->wii_inode)
> > +#define ECRYPTFS_SUPERBLOCK_TO_PRIVATE(super) ((struct ecryptfs_sb_info *) \
> > +                                               (super)->s_fs_info)
> > +#define ECRYPTFS_SUPERBLOCK_TO_PRIVATE_SM(super) ((super)->s_fs_info)
> > +#define ECRYPTFS_SUPERBLOCK_TO_LOWER(super) \
> > +        (ECRYPTFS_SUPERBLOCK_TO_PRIVATE(super)->wsi_sb)
> > +#define ECRYPTFS_DENTRY_TO_PRIVATE_SM(dentry) ((dentry)->d_fsdata)
> > +#define ECRYPTFS_DENTRY_TO_PRIVATE(dentry) ((struct ecryptfs_dentry_info *) \
> > +                                            (dentry)->d_fsdata)
> > +#define ECRYPTFS_DENTRY_TO_LOWER(dentry) \
> > +        (ECRYPTFS_DENTRY_TO_PRIVATE(dentry)->wdi_dentry)
>
> These wrappers seem rather pointless and obfuscating...

I find them make the code a bit more clear. Then again, I understand
what they do and use them a lot, so I am clearly jaded. You are the
first person to comment on these wrappers (all previous comments where
regarding some debug wrappers we had in when we first submitted, I
like those ones too, but I guess my opinion doesn't carry enough
weight here ;P) There is no functional reason why these can't be
removed, but like I said, I think they make the code a lot easier to
read once you know all they do is sugar-coat a potentially long, and
potentially confusing, chain of refences, and turn that into some
phrase-like macro.

>
> > +int virt_to_scatterlist(const void *addr, int size, struct scatterlist *sg,
> > +                       int sg_size);
>
> Doesn't seem ecryptfs specific, why is it here?

Ah ha, that should read ecryptfs_virt_to_scatterlist. Again, will be
changed for next submission. While reviewing the code, there seem to
be a few more like this. I'll make sure they get updated.

>
>                                           Pekka
> -
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--
Michael C. Thompson <mcthomps@us.ibm.com>
Software-Engineer, IBM LTC Security
