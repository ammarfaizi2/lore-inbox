Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbVKJTVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbVKJTVm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 14:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932165AbVKJTVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 14:21:42 -0500
Received: from smtpout.mac.com ([17.250.248.71]:16374 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932164AbVKJTVl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 14:21:41 -0500
In-Reply-To: <17267.19126.260133.903822@gargle.gargle.HOWL>
References: <20051107204136.GG19593@austin.ibm.com> <1131412273.14381.142.camel@localhost.localdomain> <20051108232327.GA19593@austin.ibm.com> <B68D1F72-F433-4E94-B755-98808482809D@mac.com> <20051109003048.GK19593@austin.ibm.com> <m27jbihd1b.fsf@Douglas-McNaughts-Powerbook.local> <20051109004808.GM19593@austin.ibm.com> <19255C96-8B64-4615-A3A7-9E5A850DE398@mac.com> <20051109111640.757f399a@werewolf.auna.net> <Pine.LNX.4.58.0511090816300.4260@shell2.speakeasy.net> <20051109192028.GP19593@austin.ibm.com> <Pine.LNX.4.61.0511091459440.12760@chaos.analogic.com> <Pine.LNX.4.58.0511091347570.31338@shell3.speakeasy.net> <20051110091517.2e9db750@werewolf.auna.net> <17267.19126.260133.903822@gargle.gargle.HOWL>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <253CB85C-E048-411E-B202-F7AB8DBFE2E7@mac.com>
Cc: "J.A. Magallon" <jamagallon@able.es>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: typedefs and structs
Date: Thu, 10 Nov 2005 14:21:36 -0500
To: Nikita Danilov <nikita@clusterfs.com>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 10, 2005, at 08:27:18, Nikita Danilov wrote:
> extern declaration in your version of bar() cannot refer to the  
> automatic variable myvar in foo().

int foo;

void bar(const int *local_var) {
     foo = *local_var + 1;
}

void show(void) {
     printf("%d\n", foo);
     bar(&foo);
     printf("%d\n", foo);
}

If GCC thought it could arbitrarily cache anything it wanted to, then  
code like this would die.  There is a whole mess of code in GCC  
designed specifically to watch for and avoid aliasing issues like these.

Cheers,
Kyle Moffett

--
Debugging is twice as hard as writing the code in the first place.   
Therefore, if you write the code as cleverly as possible, you are, by  
definition, not smart enough to debug it.
   -- Brian Kernighan


