Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262357AbVCBRA6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262357AbVCBRA6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 12:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262370AbVCBQ7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 11:59:31 -0500
Received: from web53704.mail.yahoo.com ([206.190.37.25]:29304 "HELO
	web53704.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262356AbVCBQ6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 11:58:15 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=rgMQJ6avE8aI8cKRWcRxdI0Jd0F/k+rRHeNHJKK9CKFEWlwf/h/zy1ikn5/4HAAB6CP5pZEeuN9vx3strh/O8FQqPxx3/bGhTV1kmTFYPybWcmis2rdboyEWvwxBiamBEYXgLvPdvJ+w+AC1ufMyKvuEKl7Pz+6a2CHjQSudM5g=  ;
Message-ID: <20050302165814.70651.qmail@web53704.mail.yahoo.com>
Date: Wed, 2 Mar 2005 08:58:14 -0800 (PST)
From: Muthian Sivathanu <muthian_s@yahoo.com>
Subject: ext3 journal commit performance
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a question on ext3 journal commit code.  When a
transaction is committed in the ordered mode, ext3
first issues the data writes, waits for them to
finish, then issues the journal writes, waits for them
to finish, and then writes out the commit record. 

It appears that the first wait (for the data blocks)
is unnecessary because all that is required is that
before the commit, both the data and the metadata
blocks should be on disk.  This extra wait can
potentially reduce performance in cases where the
journal is on a separate disk, because you lose
parallelism between data writes and the metadata
writes.

Does anyone have an idea as to why this extra wait was
introduced?

thanks very much,
Muthian 

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
