Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262308AbTKNKnj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 05:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262327AbTKNKnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 05:43:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:57259 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262308AbTKNKng (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 05:43:36 -0500
Date: Fri, 14 Nov 2003 11:43:35 +0100 (MET)
From: "Svetoslav Slavtchev" <svetljo@gmx.de>
To: "lkml " <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Subject: new reiser4 snapshot is available
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0020183004@gmx.net
X-Authenticated-IP: [213.23.34.93]
Message-ID: <26442.1068806615@www67.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

1.)--------------------------------------------------
is this done on purpose ?

  CC [M]  fs/reiser4/blocknrset.o
  CC [M]  fs/reiser4/super.o
fs/reiser4/super.c: In function `statfs_type':
fs/reiser4/super.c:41: warning: integer overflow in expression
  CC [M]  fs/reiser4/oid.o
  CC [M]  fs/reiser4/tree_walk.o

gcc version 3.3.1 (Mandrake Linux 9.2 3.3.1-2mdk)

const __u32 REISER4_SUPER_MAGIC = 0x52345362;   /* (*(__u32 *)"R4Sb"); */

static __u64 reserved_for_gid(const struct super_block *super, gid_t gid);
static __u64 reserved_for_uid(const struct super_block *super, uid_t uid);
static __u64 reserved_for_root(const struct super_block *super);

/* Return reiser4-specific part of super block */
reiser4_super_info_data *
get_super_private_nocheck(const struct super_block *super       /* super
block
                                                                 * queried
*/ )
{
        return (reiser4_super_info_data *) super->s_fs_info;
}


/* Return reiser4 fstype: value that is returned in ->f_type field by
statfs() */
long
statfs_type(const struct super_block *super UNUSED_ARG  /* super block
                                                         * queried */ )
{
        assert("nikita-448", super != NULL);
        assert("nikita-449", is_reiser4_super(super));
        return (long) REISER4_SUPER_MAGIC;

2.)--------------------------------------------------------
 CC [M]  fs/jbd/transaction.o
fs/jbd/transaction.c: In function `journal_start':
fs/jbd/transaction.c:283: error: structure has no member named
`journal_info'
fs/jbd/transaction.c:288: error: structure has no member named
`journal_info'
fs/jbd/transaction.c: In function `journal_stop':
fs/jbd/transaction.c:1363: error: structure has no member named
`journal_info'
make[2]: *** [fs/jbd/transaction.o] Error 1
make[1]: *** [fs/jbd] Error 2
make: *** [fs] Error 2

3.)---------------------------------------------------
could you please split the patch ?
may be also drop *.orig :-)
but more importantly drop/splut the uml changes

best,

svetljo

PS.

please CC me as i'm not subscribed

-- 
NEU FÜR ALLE - GMX MediaCenter - für Fotos, Musik, Dateien...
Fotoalbum, File Sharing, MMS, Multimedia-Gruß, GMX FotoService

Jetzt kostenlos anmelden unter http://www.gmx.net

+++ GMX - die erste Adresse für Mail, Message, More! +++

