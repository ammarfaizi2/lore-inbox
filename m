Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751302AbWDXV34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbWDXV34 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 17:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbWDXV3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 17:29:55 -0400
Received: from smtpout.mac.com ([17.250.248.184]:12024 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751302AbWDXV3o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 17:29:44 -0400
In-Reply-To: <444D3D32.1010104@argo.co.il>
References: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com> <1145911546.1635.54.camel@localhost.localdomain> <444D3D32.1010104@argo.co.il>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A6E165E4-8D43-4CF8-B48C-D4B0B28498FB@mac.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Gary Poppitz <poppitzg@iomega.com>,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Compiling C++ modules
Date: Mon, 24 Apr 2006 17:29:24 -0400
To: Avi Kivity <avi@argo.co.il>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 24, 2006, at 17:03:46, Avi Kivity wrote:
> Alan Cox wrote:
>> There are a few anti C++ bigots around too, but the kernel choice  
>> of C was based both on rational choices and experimentation early  
>> on with the C++ compiler.
>
> Times have changed, though. The C++ compiler is much better now,  
> and the recent slew of error handling bugs shows that C is a very  
> unsafe language.
>
> I think it's easy to show that the equivalent C++ code would be  
> shorter, faster, and safer.

Really?  What features exactly does C++ have over C that you think  
make that true?  Implicit memory allocation? Exceptions?  Operator  
overloading?  Tendency to use StudlyCaps?  What else can C++ do that  
C can not?

For example, I could write the following:

class Foo {
public:
	Foo() { /* ... init code ... */ }
	~Foo() { /* ... free code ... */ }
	int do_thing(int arg) { /* ... code ... */ }

private:
	int data_member;
};

Or I could write it like this:

struct foo {
	int data_member;
};

int foo_init() { /* ... init code ... */ }
int foo_destroy() { /* ... free code ... */ }
int foo_do_thing(int arg) { /* ... code ... */ }


The "advantages" of the former over the latter:

(1)  Without exceptions (which are fragile in a kernel), the former  
can't return an error instead of initializing the Foo.

(2)  You can't control when you initialize the Foo.  For example in  
this code, the "Foo item;" declarations seem to be trivially  
relocatable, even if they're not.
     spin_lock(&foo_lock);
     Foo item1;
     Foo item2;
     spin_unlock(&foo_lock);

(3)  Foo could theoretically implement overloaded operators.  How  
exactly is it helpful to do math on structs?  Does that actually make  
it any easier to understand the code?  How does it make it more  
obvious to be able to write a "+" operator that allocates memory?


Cheers,
Kyle Moffett

