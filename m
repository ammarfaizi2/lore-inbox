Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261790AbVF0Dmq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261790AbVF0Dmq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 23:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261795AbVF0Dmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 23:42:46 -0400
Received: from smtpout.mac.com ([17.250.248.71]:26830 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261790AbVF0DlH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 23:41:07 -0400
In-Reply-To: <42BF7167.80201@slaphack.com>
References: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl> <42BCD93B.7030608@slaphack.com> <200506251420.j5PEKce4006891@turing-police.cc.vt.edu> <42BDA377.6070303@slaphack.com> <200506252031.j5PKVb4Y004482@turing-police.cc.vt.edu> <42BDC422.6020401@namesys.com> <42BE3645.4070806@cisco.com> <e692861c05062522071fe380a5@mail.gmail.com> <42BE563D.4000402@cisco.com> <42BE5DB6.8040103@slaphack.com> <200506261816.j5QIGMdI010142@turing-police.cc.vt.edu> <42BF08CF.2020703@slaphack.com> <200506262105.j5QL5kdR018609@turing-police.cc.vt.edu> <42BF2DC4.8030901@slaphack.com> <200506270040.j5R0eUNA030632@turing-police.cc.vt.edu> <42BF667C.50606@slaphack.com> <5284F665-873C-45B7-8DDB-5F475F2CE399@mac.com> <42BF7167.80201@slaphack.com>
Mime-Version: 1.0 (Apple Message framework v730)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <EC02A684-815A-4DF8-B5C1-9029FE45E187@mac.com>
Cc: Valdis.Kletnieks@vt.edu, Lincoln Dale <ltd@cisco.com>,
       Gregory Maxwell <gmaxwell@gmail.com>, Hans Reiser <reiser@namesys.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: reiser4 plugins
Date: Sun, 26 Jun 2005 23:40:35 -0400
To: David Masover <ninja@slaphack.com>
X-Mailer: Apple Mail (2.730)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 26, 2005, at 23:24:23, David Masover wrote:
>> Neither do I want the kernel to unzip it, because that just   
>> introduces the
>> kernel to a whole series of normally application-level  
>> vulnerabilities.
>
> That just means the zip plugin has to be more carefully written than I
> thought.  It would have to be sandboxed and limited to prevent buffer
> overruns and zip bombs.



> Remember that zip, at least, would not be in the kernel.  I think what
> is going in the kernel is gzip and lzo, and it's being done so
> transparently that you never actually see the compressed version.


>> Can you illustrate for me with precise, clear, and unambiguous  
>> arguments
>
> That will take some time.  And some thinking.

Precisely.  Come back when you have a good sturdy set of arguments.  See
the FUSE project (Also discussed in this thread), for better ideas on  
how
to add strange filesystem semantics.  NOTE:  Even the FUSE project,  
which
is in _userspace_ (as opposed to the massive kernelspace mess of  
reiser4),
is taking a lot of flak for changing UNIX semantics, so I see no reason
why Reiser4 should be special.

>> how this can avoid all possible pitfalls,
>
> Especially if you want perfection.

It doesn't need perfection, it just needs to convince a large segment of
the developers on this list (and especially linus).

>> including the automatic encryption/decryption and most other non-  
>> standard
>> filesystem features (Basically the whole '...' directory), should   
>> probably
>> be left out of any patch submitted for inclusion until they can be
>> _proven_ (or at least thoroughly checked) not to have undesirable  
>> results.
>
> I am doing that out of habit.  Actually, it probably ends up more as:
>   .../foo.zip/
> instead of
>   foo.zip/.../
>
> But, it is left out.  At least that interface.

Ok, good.  That's one of the first issues.  A _lot_ of applications  
would get
themselves thoroughly confused at that '...' interface, not to  
mention a lot
of sysadmins :-D.

> Now, the cryptocompress as it currently stands does not involve ...  
> and
> does not introduce any new security holes in the way that you are
> describing.

Good.  I think that we can all agree that, in the event  
cryptocompress is
included, it would be a nice feature to have in all filesystems.   
Therefore,
we should attempt to come up with a clean interface with which it  
could be
added _inside_ the VFS.

> There might be some issues with key management (someone
> hinted vaguely at that), but nothing insurmountable.

Likewise, this should be handled in a common VFS interface that all FSs
can use.  There already exists a key management system that would not be
particularly difficult to interface with, but it would take thought and
discussion.

Cheers,
Kyle Moffett

--
There are two ways of constructing a software design. One way is to  
make it so simple that there are obviously no deficiencies. And the  
other way is to make it so complicated that there are no obvious  
deficiencies.
  -- C.A.R. Hoare

