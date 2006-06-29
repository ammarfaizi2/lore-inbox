Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751864AbWF2KrG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751864AbWF2KrG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 06:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751868AbWF2KrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 06:47:05 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:5614 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S1751864AbWF2KrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 06:47:04 -0400
Message-ID: <04d401c69b69$581db0d0$4168010a@bsd.tnes.nec.co.jp>
From: "Takashi Sato" <sho@tnes.nec.co.jp>
To: "Andreas Dilger" <adilger@clusterfs.com>,
       "Johann Lombardi" <johann.lombardi@bull.net>
Cc: <ext2-devel@lists.sourceforge.net>, <cmm@us.ibm.com>,
       <linux-kernel@vger.kernel.org>
References: <20060628205238sho@rifu.tnes.nec.co.jp><20060628155048.GG2893@chiva> <20060628202421.GL5318@schatzie.adilger.int>
Subject: Re: [Ext2-devel] [RFC 1/2] ext3: enlarge blocksize and fix rec_lenoverflow
Date: Thu, 29 Jun 2006 19:46:52 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2869
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> On Jun 28, 2006  17:50 +0200, Johann Lombardi wrote:
>> ext2/ext3_dir_entry_2 has a 16-bit entry(rec_len) and it would overflow
>> with 64KB blocksize.  This patch prevent from overflow by limiting
>> rec_len to 65532.
> 
> Having a max rec_len of 65532 is rather unfortunate, since the dir
> blocks always need to filled with dir entries.

Oh, that's right.

> 65536 - 65532 = 4, and
> the minimum ext3_dir_entry size is 8 bytes.  I would instead make this
> maybe 64 bytes less so that there is room for a filename in the "tail"
> dir_entry.

What does "64 bytes" mean?
Do you mean that the following dummy entry should be added
at the tail of the directory block?

struct ext3_dir_entry_2 {
 __le32 inode   = 0
 __le16 rec_len = 16
 __u8 name_len  = 4
 __u8 file_type = 0
 char name      = "dir_end"
};

Cheers, sho 
