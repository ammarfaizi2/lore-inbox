Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131334AbQJ1XoQ>; Sat, 28 Oct 2000 19:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131371AbQJ1Xn5>; Sat, 28 Oct 2000 19:43:57 -0400
Received: from mail.archerassoc.com ([12.14.185.5]:22025 "EHLO
	digitalpassage.com") by vger.kernel.org with ESMTP
	id <S131334AbQJ1Xnt>; Sat, 28 Oct 2000 19:43:49 -0400
Date: Sat, 28 Oct 2000 18:43:42 -0500
To: linux-kernel@vger.kernel.org
Subject: kernel BUG at fs.c:567
Message-ID: <20001028184342.A1525@intolerance.digitalpassage.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: Stephen Crowley <stephenc@digitalpassage.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel 2.4.0-test10-pre6, but this has been here as long as I can
remember.

starting wine triggers the bug, C: points to /win2k which is an NTFS
filesystem.

The offending code..

/* It's fscking broken. */
        
static int ntfs_get_block(struct inode *inode, long block, struct buffer_head *bh, int create)
{
        BUG();
        return -1;
}
		
Heh. is there something else can be done there instead of just taking a crap
on itself? I can no longer read anything from /proc after this happens.

Oct 28 18:27:54 intolerance kernel: kernel BUG at fs.c:567!
Oct 28 18:27:54 intolerance kernel: invalid operand: 0000
Oct 28 18:27:54 intolerance kernel: CPU:    0
Oct 28 18:27:54 intolerance kernel: EIP:    0010:[ntfs_get_block+20/32]
Oct 28 18:27:54 intolerance kernel: EFLAGS: 00210282
Oct 28 18:27:54 intolerance kernel: eax: 00000018   ebx: cc95e2c0   ecx: c6bc2000   edx: cf974520
Oct 28 18:27:54 intolerance kernel: esi: 00000000   edi: 0000000b   ebp: 00000800   esp: c6bc3dfc
Oct 28 18:27:54 intolerance kernel: ds: 0018   es: 0018   ss: 0018
Oct 28 18:27:54 intolerance kernel: Process wine (pid: 1502, stackpage=c6bc3000)
Oct 28 18:27:54 intolerance kernel: Stack: c0215e52 c0216278 00000237 c012f904 c70f7340 00000000 cc95e2c0 00000000 
Oct 28 18:27:54 intolerance kernel:        00000000 c11c6170 00000000 c70f73dc 00000000 00000000 00000000 cc95e2c0 
Oct 28 18:27:54 intolerance kernel:        000002a4 c70f7340 00000000 c0122263 c11c6170 c11c6170 c1480eb4 00000000 
Oct 28 18:27:54 intolerance kernel: Call Trace: [tvecs+44350/74220] [tvecs+45412/74220] [block_read_full_page+236/488] [add_to_p age_cache_unique+267/280] [ntfs_readpage+15/20] [ntfs_get_block+0/32] [read_cluster_nonblocking+258/324] 
Oct 28 18:27:54 intolerance kernel:        [filemap_nopage+304/776] [filemap_nopage+0/776] [do_no_page+80/176] [handle_mm_fault+ 231/340] [do_page_fault+315/992] [do_page_fault+0/992] [old_mmap+192/240] [old_mmap+224/240] 
Oct 28 18:27:54 intolerance kernel:        [error_code+52/60] 
Oct 28 18:27:54 intolerance kernel: Code: 0f 0b 83 c4 0c b8 ff ff ff ff c3 90 8b 44 24 08 68 90 fb 14 


Please CC: responses, I'm not subscribed to the list.

-- 
Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
