Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289756AbSAPMxt>; Wed, 16 Jan 2002 07:53:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289921AbSAPMxk>; Wed, 16 Jan 2002 07:53:40 -0500
Received: from d12lmsgate-3.de.ibm.com ([195.212.91.201]:45511 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S289756AbSAPMxW> convert rfc822-to-8bit; Wed, 16 Jan 2002 07:53:22 -0500
Importance: Normal
Subject: RFC: Bug in ext2?
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.4a  July 24, 2000
Message-ID: <OF8874D237.85B223A3-ONC1256B43.004BF905@de.ibm.com>
From: "Carsten Otte" <COTTE@de.ibm.com>
Date: Wed, 16 Jan 2002 14:52:56 +0100
X-MIMETrack: Serialize by Router on D12ML033/12/M/IBM(Release 5.0.8 |June 18, 2001) at
 16/01/2002 13:54:19
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello kernel-list-readers,

I am currently reviewing the second extended fs. I found the following
code in fs/ext2/super.c (taken from kernel 2.4.17):

static int ext2_setup_super (struct super_block * sb,
                     struct ext2_super_block * es,
                     int read_only)
{
     int res = 0;
     if (le32_to_cpu(es->s_rev_level) > EXT2_MAX_SUPP_REV) {
          printk ("EXT2-fs warning: revision level too high, "
               "forcing read-only mode\n");
          res = MS_RDONLY;
     }
     if (read_only)
          return res;
------------------8<-------------------------------*SNIPP*
     ext2_write_super(sb);
------------------8<-------------------------------*SNIPP*
     return res;
}
To me, it looks like if the fs revision in the super block is higher than
the
supported one while read_only is false, the result is set to MS_RDONLY,
but the super block will be written anyway.
I'd expect that MS_RDONLY should be returned at the beginning of the
funcion & the super block of a fs with an unsupported revision should _not_
be written. Am I getting  s.th. wrong?


mit freundlichem Gruß / with kind regards
Carsten Otte

IBM Deutschland Entwicklung GmbH
Linux for eServer development - device driver team
Phone: +49/07031/16-4076
IBM internal phone: *120-4076
--
We are Linux.
Resistance indicates that you're missing the point!

