Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751113AbWCYT3R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbWCYT3R (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 14:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbWCYT3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 14:29:17 -0500
Received: from ms-smtp-02-smtplb.tampabay.rr.com ([65.32.5.132]:42927 "EHLO
	ms-smtp-02.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S1751068AbWCYT3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 14:29:16 -0500
Message-ID: <442599D5.806@cfl.rr.com>
Date: Sat, 25 Mar 2006 14:28:21 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Mail/News 1.5 (X11/20060309)
MIME-Version: 1.0
To: Michael Halcrow <mhalcrow@us.ibm.com>
CC: akpm@osdl.org, phillip@hellewell.homeip.net, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, viro@ftp.linux.org.uk, mike@halcrow.us,
       mcthomps@us.ibm.com, yoder1@us.ibm.com, toml@us.ibm.com,
       emilyr@us.ibm.com, daw@cs.berk
Subject: Re: eCryptfs Design Document
References: <20060324222517.GA13688@us.ibm.com>
In-Reply-To: <20060324222517.GA13688@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Halcrow wrote:
> * A mount-wide passphrase is stored in the user session 
>   keyring in the form of an authentication token.

I'm a bit confused because you appear to be contradicting yourself.  You 
say several times that a mount-wide passphrase is used for the master 
key.  If that is the case, then it would be given at mount time and be 
bound to the super block.  You also then say that the master key is 
stored in the kernel keyring.  If that is the case, then you don't have 
to know the key at mount time, rather the key is associated with a given 
process or group of processes and will be required when such a process 
attempts to open a file on that mount point.  This would also allow 
different users to use different keys.


So which is it?  Is the master key bound to the superblock, or to the 
session keyring?  Or am I just confused about the meaning of the kernel 
keyring?

> passphrase into a key follows the S2K process as described in RFC
> 2440, in that the passphrase is concatenated with a salt; that data
> block is then iteratively MD5-hashed 65,536 times to generate the key
> that encrypts the file encryption key.


Are you saying that you salt the passphrase, hash that, then hash the 
hash, then hash that hash, and so on?  What good does repeatedly hashing 
the hash do?  Simply hashing the salted passphrase should be sufficient 
to obtain a key.


