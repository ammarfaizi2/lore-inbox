Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269216AbTCBOEZ>; Sun, 2 Mar 2003 09:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269218AbTCBOEZ>; Sun, 2 Mar 2003 09:04:25 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:43738 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S269216AbTCBODa>; Sun, 2 Mar 2003 09:03:30 -0500
Message-Id: <200303021413.PAA12289@post.webmailer.de>
From: Arnd Bergmann <arnd@bergmann-dalldorf.de>
Subject: Re: [PATCH] reduce large stack usage
To: "Randy.Dunlap" <randy.dunlap@verizon.net>, linux-kernel@vger.kernel.org
Date: Sun, 02 Mar 2003 15:11:40 +0100
References: <20030301071007$18ea@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:

> This patch to 2.5.63 reduces stack usage in generate_default_upcase()
> from 0x3d4 bytes to just noise (on x86).

Since you are already fixing stack usage bugs in several places, maybe
you are interested in this list. I have it from building 2.5.63 with 
allyesconfig on s390x with gcc-2.95.3. The twofish one is obviously
broken, and I suspect huft_build/inflate_dynamic are the cause of the
crashes I'm seeing during unpacking of initramfs.

nfs4 and reiserfs look suspicious as well, but I've never used either
of them on s390x, so I can't tell if they are likely to cause
real problems.

        Arnd <><

8832 twofish_setkey
1696 dohash
1680 huft_build
1680 huft_build
1544 aes_encrypt
1512 inflate_dynamic
1496 inflate_dynamic
1448 device_new_if
1360 inflate_fixed
1360 inflate_fixed
1344 br_ioctl_device
1312 elf_core_dump
1264 sctp_hash_digest
1256 aes_decrypt
1248 gss_pipe_downcall
1248 befs_warning
1248 befs_error
1248 befs_debug
1232 ciGetLeafPrefixKey
1216 nfs4_proc_rename
1192 nfs4_proc_link
1184 root_nfs_name
1184 conmode_default
1136 elf_core_dump
1128 nfsd4_proc_compound
1112 generate_default_upcase
1072 nlmclnt_proc
1016 do_open
1000 reiserfs_rename
992 reiserfs_delete_solid_item
992 nfs4_proc_symlink
992 nfs4_proc_mknod
992 nfs4_proc_mkdir
968 nlmclnt_reclaim
936 reiserfs_delete_item
912 reiserfs_cut_from_item
896 extract_entropy
888 sha512_transform
872 udf_add_entry
840 reiserfs_insert_item
832 tcp_v4_conn_request
832 reiserfs_paste_into_item
824 nfs4_proc_lookup
824 hfs_cat_move
816 udf_load_pvoldesc
816 semctl_main
792 sys_shmctl

generated from:
objdump --disassemble vmlinux |
        grep '\(^0\|aghi.%r15\)' |
        sed -e 's/^0.*<\(.*\)>:/\1/g' -e 's/^ .*-/: /g' |
        while read a b ; do
                if [ $a = : ] ; then
                        echo $b $name
                fi
                name=$a
        done |
        sort -rn |
        head -n 40
