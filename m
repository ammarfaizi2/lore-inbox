Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264925AbSJ3UAt>; Wed, 30 Oct 2002 15:00:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264904AbSJ3T7K>; Wed, 30 Oct 2002 14:59:10 -0500
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:51952 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S264902AbSJ3T4r>; Wed, 30 Oct 2002 14:56:47 -0500
From: Andreas Dilger <adilger@clusterfs.com>
Date: Wed, 30 Oct 2002 13:00:20 -0700
To: "Matthew J. Fanto" <mattf@mattjf.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: The Ext3sj Filesystem
Message-ID: <20021030200020.GV28982@clusterfs.com>
Mail-Followup-To: "Matthew J. Fanto" <mattf@mattjf.com>,
	linux-kernel@vger.kernel.org
References: <200210301434.17901.mattf@mattjf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210301434.17901.mattf@mattjf.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 30, 2002  14:34 -0500, Matthew J. Fanto wrote:
> I am annoucing the development of the ext3sj filesystem. Ext3sj is a new 
> encrypted filesystem based off ext3. Ext3sj is an improvement over the 
> current loopback solution because we do not in fact require a loopback 
> device. Encryption/decryption is transparent to the user, so the only thing 
> they will need to know is their key, and how to mount a device. We do not 
> encrypt the entire volume under the same key as some solutions do (this can 
> not only aid in a known-plaintext attack, but it gives the users less 
> options). Instead, every file is encrypted seperately under the key of the 
> users choice. We are also adding support for reading keys off floppies, 
> cdroms, and USB keychain drives. Currently, ext3sj supports the following 
> algorithms: AES, 3DES, Twofish, Serpent, RC6, RC5, RC2, Blowfish, CAST-256, 
> XTea, Safer+, SHA1, SHA256, SHA384, SHA512, MD5, with more to come. 
> If anyone has any comments, questions, or would like to request an algorithm 
> be added, please let me know. 

Some notes:
1) having so many encryption algorithms is a huge pain in the ass, and
   it will never be accepted into the kernel like that.  Pick some
   "good" encryption algorithms (like those that will be supported as
   part of IPSec and/or the encrypted loop devices: 3DES, AES, RC5 or
   whatever) and then there can be some re-use with other parts of the kernel.
2) "not requiring a loopback device" is in itself only a marginal
   benefit at best
3) It would probably be beneficial to add this as part of the ext2compr
   code, since it already handles per-file munging, and it is very common to
   do compression as a pre-processing step to encryption to reduce the
   redundancy in the input data

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

