Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285334AbRLGAQJ>; Thu, 6 Dec 2001 19:16:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285329AbRLGAP4>; Thu, 6 Dec 2001 19:15:56 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:61962 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S285334AbRLGAOu>; Thu, 6 Dec 2001 19:14:50 -0500
Message-ID: <3C1009B8.8080300@namesys.com>
Date: Fri, 07 Dec 2001 03:13:44 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com,
        ramon@thebsh.namesys.com, yura@namesys.com
Subject: Re: [reiserfs-dev] Re: Ext2 directory index: ALS paper and benchmarks
In-Reply-To: <E16BjYc-0000hS-00@starship.berlin> <E16Bppx-0000mN-00@starship.berlin> <3C0F7659.1090701@namesys.com> <E16C2EN-0000pz-00@starship.berlin>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:

>On December 6, 2001 02:44 pm, Hans Reiser wrote:
>
>>Daniel Phillips wrote:
>>
>>>On December 6, 2001 04:56 am, Hans Reiser wrote:
>>>
>>>>>On December 6, 2001 04:41 am, you wrote:
>>>>>
>>>>>>ReiserFS is an Htree by your definition in your paper, yes?
>>>>>>
>>>>>You've got a hash-keyed b*tree over there.  The htree is fixed depth.
>>>>>
>>>>B*trees are fixed depth.  B-tree usually means height-balanced.  
>>>>
>>>I was relying on definitions like this:
>>>
>>> B*-tree
>>>
>>> (data structure)
>>>
>>> Definition: A B-tree in which nodes are kept 2/3 full by redistributing
>>> keys to fill two child nodes, then splitting them into three nodes.
>>>
>>This is the strangest definition I have read.  Where'd you get it?
>>
>>
>
>This came from:
>
>   http://www.nist.gov/dads/HTML/bstartree.html
>
>Here's another, referring to Knuth's original description:
>
>   http://www.cise.ufl.edu/~jhammer/classes/b_star.html
>

Hmmmm, the definition I think I remember came I think from Wood's book 
on Algorithms, and unfortunately it disappeared from my office some time 
ago.

My memory was that a B*-tree handles variable length records.  It seems 
I am wrong though.  Dear.  I'd better go tell the tech writer.

ReiserFS is a B*-tree by both definitions though.  (Convenient at the 
moment:-) )

>
>
>>>To tell the truth, I haven't read your code that closely, sorry, but I got 
>>>the impression that you're doing rotations for balancing no?  If not then 
>>>
>>What are rotations?
>>
>
>Re-rooting a (sub)tree to balance it.  <Pulls Knuth down from shelf>
>For a BTree, rotating means shifting keys between siblings rather than 
>re-parenting.  (The latter would change the path lengths and the result 
>wouldn't be a BTree.)
>
>So getting back to your earlier remark, when examined under a bright light, 
>an HTree looks quite a lot like a BTree, the principal difference being the 
>hash and consequent collision handling.  An HTree is therefore a BTree with 
>wrinkles.
>
Hmmm, well we do hashes too.  But I see your hash collision handling 
resembles (but with some interesting improvements) something once 
suggested by one of my programmers.  What happens when you have two 
collisions in one node, and then you delete one colliding name?  Do you 
leak collision bits?

When you rehash a large directory, is there a brief service interruption?


>
>
><reads more> But wait, you store references to objects along with keys, I 
>don't.  So where does that leave us?
>
>By the way, how do you handle collisions?  I see it has something to do with 
>generation numbers, but I haven't fully decoded the algorithm.
>
>Fully understanding your code is going to take some time.  This would 
>go faster if I could find the papers mentioned in the comments, can you point 
>me at those?
>
Which papers in which comments?

>
>
>--
>Daniel
>
>
>
Yura, can you run some benchmarks on this code?


