Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964832AbVIUU7v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964832AbVIUU7v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 16:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964837AbVIUU7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 16:59:51 -0400
Received: from zctfs063.nortelnetworks.com ([47.164.128.120]:24706 "EHLO
	zctfs063.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S964835AbVIUU7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 16:59:50 -0400
Message-ID: <4331C9B2.5070801@nortel.com>
Date: Wed, 21 Sep 2005 14:59:30 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sonny Rao <sonny@burdell.org>
CC: linux-kernel@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
       dipankar@in.ibm.com, bharata@in.ibm.com
Subject: Re: dentry_cache using up all my zone normal memory -- also seen
 on 2.6.14-rc2
References: <433189B5.3030308@nortel.com> <43318FFA.4010706@nortel.com> <4331B89B.3080107@nortel.com> <20050921200758.GA25362@kevlar.burdell.org>
In-Reply-To: <20050921200758.GA25362@kevlar.burdell.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Sep 2005 20:59:40.0596 (UTC) FILETIME=[62527740:01C5BEEF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sonny Rao wrote:

> Over one million files open at once is just asking for trouble on a
> lowmem-crippled x86 machine, IMHO.

I don't think there actually are.  I ran the testcase under strace, and 
it appears that there are two threads going at once.

thread 1 spins doing the following:
fd = creat("./rename14", 0666);
unlink("./rename14");
close(fd);

thread 2 spins doing:
rename("./rename14", "./rename14xyz");

Chris
