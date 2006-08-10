Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161478AbWHJR0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161478AbWHJR0N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 13:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161484AbWHJR0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 13:26:12 -0400
Received: from mail.tmr.com ([64.65.253.246]:19099 "EHLO pixels.tmr.com")
	by vger.kernel.org with ESMTP id S1161478AbWHJR0L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 13:26:11 -0400
Message-ID: <44DB6CCE.9010708@tmr.com>
Date: Thu, 10 Aug 2006 13:28:46 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.5) Gecko/20060720 SeaMonkey/1.0.3
MIME-Version: 1.0
To: Valerie Henson <val_henson@linux.intel.com>
CC: dean gaudet <dean@arctic.org>, David Lang <dlang@digitalinsight.com>,
       Mark Fasheh <mark.fasheh@oracle.com>, Chris Wedgwood <cw@f00f.org>,
       Arjan van de Ven <arjan@linux.intel.com>,
       Dave Kleikamp <shaggy@austin.ibm.com>, Christoph Hellwig <hch@lst.de>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Akkana Peck <akkana@shallowsky.com>,
       Jesse Barnes <jesse.barnes@intel.com>, jsipek@cs.sunysb.edu,
       Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [RFC] [PATCH] Relative lazy atime
References: <20060803063622.GB8631@goober> <20060805122537.GA23239@lst.de> <1154797123.12108.6.camel@kleikamp.austin.ibm.com> <1154797475.3054.79.camel@laptopd505.fenrus.org> <20060805183609.GA7564@tuatara.stupidest.org> <20060805222247.GQ29686@ca-server1.us.oracle.com> <Pine.LNX.4.63.0608051604420.20114@qynat.qvtvafvgr.pbz> <Pine.LNX.4.64.0608051612330.20926@twinlark.arctic.org> <20060806030147.GG4379@parisc-linux.org> <20060809063947.GA13474@goober>
In-Reply-To: <20060809063947.GA13474@goober>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valerie Henson wrote:
> On Sat, Aug 05, 2006 at 09:01:47PM -0600, Matthew Wilcox wrote:
>> On Sat, Aug 05, 2006 at 04:28:29PM -0700, dean gaudet wrote:
>>> you can work around mutt's silly dependancy on atime by configuring it 
>>> with --enable-buffy-size.  so far mutt is the only program i've discovered 
>>> which cares about atime.
>> For the shell, atime is the difference between 'you have mail' and 'you
>> have new mail'.
>>
>> I still don't understand though, how much does this really buy us over
>> nodiratime?
> 
> Lazy atime buys us a reduction in writes over nodiratime for any
> workload which reads files, such as grep -r, a kernel compile, or
> backup software.  Do I misunderstand the question?

I mentioned lazy atime about a year ago, and have played with a patch to 
do what I (personally) had in mind. My thinking is that for files the 
atime is almost always used in one of two ways, as part of system 
administration to see if a file is being used, and to sort files by 
atime to identify recently accessed files, such as the one you read just 
before the weekend.

So in that light, I proposed that a filesystem might have a mount option 
such that atime was only updated when an open or close was done on the 
file. In many cases this will both reduce inode writes and still 
preserve information "current enough" to be useful, which is unavailable 
with noatime. And since noatime is thought useful as a attribute, lazy 
atime probably would be, as well.

-- 
Bill Davidsen <davidsen@tmr.com>
   Obscure bug of 2004: BASH BUFFER OVERFLOW - if bash is being run by a
normal user and is setuid root, with the "vi" line edit mode selected,
and the character set is "big5," an off-by-one errors occurs during
wildcard (glob) expansion.
