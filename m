Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285704AbRLHARU>; Fri, 7 Dec 2001 19:17:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285705AbRLHARL>; Fri, 7 Dec 2001 19:17:11 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:15877 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S285704AbRLHARD>; Fri, 7 Dec 2001 19:17:03 -0500
Message-ID: <3C115BB6.5050402@namesys.com>
Date: Sat, 08 Dec 2001 03:15:50 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Ragnar =?ISO-8859-1?Q?Kj=F8rstad?= <reiserfs@ragnark.vestdata.no>
CC: Daniel Phillips <phillips@bonn-fries.net>, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com, Nikita Danilov <god@namesys.com>,
        green@thebsh.namesys.com
Subject: Re: [reiserfs-dev] Re: Ext2 directory index: ALS paper and benchmarks
In-Reply-To: <E16BjYc-0000hS-00@starship.berlin> <3C0EE8DD.3080108@namesys.com> <20011206122753.A9253@vestdata.no> <E16CNHk-0000u4-00@starship.berlin> <20011207174726.B6640@vestdata.no> <3C112E20.2080105@namesys.com> <20011207235641.B18104@vestdata.no>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ragnar Kjørstad wrote:

>On Sat, Dec 08, 2001 at 12:01:20AM +0300, Hans Reiser wrote:
>
>>>In the cases I've studied more closely (e.g. maildir cases) the problem
>>>with reiserfs and e.g. the tea hash is that there is no common ordering
>>>between directory entries, stat-data and file-data.
>>>
>>>When new files are created in a directory, the file-data tend to be
>>>allocated somewhere after the last allocated file in the directory. The
>>>ordering of the directory-entry and the stat-data (hmm, both?) are
>>>
>>no, actually this is a problem for v3.  stat data are time of creation 
>>ordered (very roughly speaking)
>>and directory entries are hash ordered, meaning that ls -l suffers a 
>>major performance penalty.
>>
>
>Yes, just remember that file-body ordering also has the same problem.
>(ref the "find . -type f | xargs cat > /dev/null" test wich I think
>represent maildir performance pretty closely)
>
>
>
So is this a deeply inherent drawback of offering readdir name orders 
that differ hugely from time of creation order?

The advantages of sorting for non-linear search time are obvious.....

I suppose we could use objectids based on the  hash of the first 
assigned filename plus a 60 bit global to the FS counter....

but it is too many bits I think.  I think that using substantially less 
than the full hash of the name that is used for directory entry keys  
doesn't work....  Comments welcome.  

Hans


