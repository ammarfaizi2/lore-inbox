Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314292AbSDRKdJ>; Thu, 18 Apr 2002 06:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314293AbSDRKdI>; Thu, 18 Apr 2002 06:33:08 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:33800 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S314292AbSDRKdF>;
	Thu, 18 Apr 2002 06:33:05 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] 2.5.8 sort kernel tables 
In-Reply-To: Your message of "Thu, 18 Apr 2002 12:21:05 +0200."
             <20020418102105.GB7884@merlin.emma.line.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 18 Apr 2002 20:32:54 +1000
Message-ID: <1911.1019125974@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Apr 2002 12:21:05 +0200, 
Matthias Andree <matthias.andree@stud.uni-dortmund.de> wrote:
>On Thu, 18 Apr 2002, Keith Owens wrote:
>
>> + * Do not assume that the table from the linker is correct, sort it at boot
>> + * time.  Since 90%+ of the entries will be sorted, a bubble sort is good
>> + * enough, it only runs once per table per boot.  The sort only does binary
>> + * keys and only sorts in ascending order.
>
>Any real-world figures on how long this sort process would take on big
>tables on some sparc or i586 class box? (Just trying to figure if bubble
>is really adequate. It is if the table is indeed essentially sorted with
>only like 10 reversed neighbours or if it's short.)

The tables are almost sorted already.  It is just the occasional entry
that is out of order, e.g.

foo.o
  .text uses copy_to_user
  .text.init uses copy_to_user
bar.o
  .text users copy_to_user
baz.o
  .text users copy_to_user

Only the .text.init exception entry will be out of order, it will
require two passes over the table to sort it.  In the simplest case
there will be no out of order entries and one pass does the job.  The
number of out of order entries is a function of how much init and exit
code does special processing, not a lot.

