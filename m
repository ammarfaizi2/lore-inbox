Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbUHYPok@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbUHYPok (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 11:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267259AbUHYPok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 11:44:40 -0400
Received: from maxipes.logix.cz ([81.0.234.97]:6274 "EHLO maxipes.logix.cz")
	by vger.kernel.org with ESMTP id S261610AbUHYPoX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 11:44:23 -0400
Message-ID: <412CB3D2.9020706@suse.cz>
Date: Wed, 25 Aug 2004 17:44:18 +0200
From: Michal Ludvig <mludvig@suse.cz>
Organization: SuSE CR, s.r.o.
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8a2) Gecko/20040606
X-Accept-Language: cs, cz, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
Cc: CryptoAPI List <cryptoapi@lists.logix.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] /dev/crypto for Linux
References: <412BB517.4040204@suse.cz> <20040825152651.A8381@infradead.org>
In-Reply-To: <20040825152651.A8381@infradead.org>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Christoph Hellwig told me that:

>>+static int
>>+clonefd(struct file *filp)
>>+{
>>+	struct files_struct * files = current->files;
>>+	int fd;
>>+
>>+	fd = get_unused_fd();
>>+	if (fd >= 0) {
>>+		get_file(filp);
>>+		FD_SET(fd, files->open_fds);
>>+		fd_install(fd, filp);
>>+	}
>>+
>>+	return fd;
>>+}
>
>
> Yikes.
>
>
>>+static int
>>+cryptodev_ioctl(struct inode *inode, struct file *filp,
>>+		unsigned int cmd, unsigned long arg)
>>+{
>>+	struct session_op sop;
>>+	struct crypt_op cop;
>>+	struct fcrypt *fcr = filp->private_data;
>>+	uint32_t ses;
>>+	int ret, fd;
>>+
>>+	if (!fcr)
>>+		BUG();
>>+
>>+	switch (cmd) {
>>+		case CRIOGET:
>>+			fd = clonefd(filp);
>>+			put_user(fd, (int*)arg);
>>+			return 0;
>
>
> Extremly bad API.  Just allow opening the device multiple times,
> and get a new context each time (can be stored in file->private_data

As I already said - these are relicts from the OpenBSD API. Will be
redesigned and rewritten.

Michal Ludvig
- --
SUSE Labs                    mludvig@suse.cz
(+420) 296.542.396        http://www.suse.cz
Personal homepage http://www.logix.cz/michal
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFBLLPQDDolCcRbIhgRAvglAJ48SiKsO2NymzGqsn9x8EYZSoMoMQCfWqsC
t8E+AdtAgZc9Wi2Ta0xz1bs=
=emM8
-----END PGP SIGNATURE-----
