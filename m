Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277000AbRJHQoR>; Mon, 8 Oct 2001 12:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276987AbRJHQoI>; Mon, 8 Oct 2001 12:44:08 -0400
Received: from nmail.altkom.com.pl ([195.94.220.102]:51730 "EHLO
	nmail.altkom.com.pl") by vger.kernel.org with ESMTP
	id <S277000AbRJHQn6>; Mon, 8 Oct 2001 12:43:58 -0400
Message-ID: <3BC1D7E8.1080407@altkom.com.pl>
Date: Mon, 08 Oct 2001 18:44:24 +0200
From: Aleksander Adamowski <olo@altkom.com.pl>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4+) Gecko/20011008
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ReiserFS Bug
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a follow-up to my report from 2001-09-01 ("Bug in ReiserFS").
I updraded to 2.4.10.
After the incident my /home filesystem was unusable, users with their 
homedirs there couldn't login (login freezed).
I've got this in /var/log/messages (timestamps stripped):


Unable to handle kernel NULL pointer dereference at virtual address 
00000008
  printing eip:
c01717be
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[leaf_copy_boundary_item+786/1796]
EFLAGS: 00010246
eax: 00001000   ebx: 00000017   ecx: c0e011e0   edx: 00000000
esi: 00003a70   edi: c3e80018   ebp: c1f95228   esp: c41817f8
ds: 0018   es: 0018   ss: 0018
Process gftp-gtk (pid: 9724, stackpage=c4181000)
Stack: c3e80018 00001000 00000011 00000017 ffffffff c0e011e0 00000000 
00000001
        c02a15c0 c016b82a c1f7a094 00000017 c0e01a80 c0172399 c41818a4 
c0e011e0
        00000001 ffffffff c41818a4 c4181894 ffffffff 00000011 c01725e0 
c41818a4
Call Trace: [get_num_ver+330/864] [leaf_copy_items+153/244] 
[leaf_move_items+68/132] [leaf_shift_right+27/68] [balance_leaf+3666/9696]
    [schedule+564/880] [__wait_on_buffer+128/140] [bread+74/104] 
[clear_all_dirty_bits+17/24] [do_balance+142/256] 
[reiserfs_insert_item+158/240]
    [indirect2direct+474/572] [maybe_indirect_to_direct+470/484] 
[reiserfs_cut_from_item+208/1104] [reiserfs_do_truncate+796/1068] 
[reiserfs_truncate_file+170/348] [reiserfs_file_release+801/844]
    [fput+76/224] [filp_close+92/100] [sys_close+67/84] 
[system_call+51/64]

Code: 8b 42 08 ff d0 83 c4 08 85 c0 75 07 31 c0 e9 d4 03 00 00 66

