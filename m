Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263480AbTIHTHV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 15:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263498AbTIHTHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 15:07:21 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:45580 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S263480AbTIHTHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 15:07:08 -0400
Message-ID: <3F5CD863.4020605@techsource.com>
Date: Mon, 08 Sep 2003 15:28:35 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Use of AI for process scheduling
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just got back from vacation and have 3278 list messages to sift
through.  (Yay.)  I wouldn't be surprised, therefore, if others were
already discussing this, but I've been thinking of some ideas over the
past week that we may be helpful for the advancement of intelligent
process scheduling.

To begin with, let's consider the parts of an intelligent system:

1) Inputs (ie. properties and behaviors of processes)
2) Heuristics
3) Outputs (ie. dynamic priorities, etc.)

Up to this point, the interactive scheduler has been designed in a very
expert-system-like manner.  Human experts observe behaviors and define
heuristics.  Ultimately, we do want a solid set of heuristics that are
coded in C, and that's what the current development process has been
working directly toward.

The progress has been slow, and there have been a lot of false starts
and tangents which have been discarded.  This is all how development
works, and it's important to explore all possibilities.  But what I
would like to propose is that we work on a way to accelerate that
process, and that is to make use of machine learning.  We move from
expert systems to artificial intelligence, because the heuristics are
determined by the machine and are therefore dynamic.

Basically, we need to write and install into the kernel an AI engine
which uses user feedback about the "feel" of the system to adjust
heuristics dynamically.  For instance, if the user sees that the system
is misbehaving, they can pause the system in the kernel debugger,
examine process priorities, and indicate what "outputs" from the AI
engine are wrong.  It then learns from that.  Heuristics can be tweaked
until things run as desired.  At that point, scheduler developers trade
emails in the AI heuristic language.

Obviously, this AI engine will be slow and add a huge amount of
processing overhead.  The idea is to determine what the heuristics are,
and then to release a kernel, recode the heuristics in C.

We have a number of options for what kinds of AI engines we use.  A 
neural net is something that's relatively easy to train, but beyond a 
certain level of complexity, it's impossible to make much sense out of 
the weights.  Genetic algorithms are probably out of the question.

The ideal situation would be to have a rule processor that uses a script 
language of sorts (lots of if-thens with some math, etc.) to compute on 
inputs and produce directives to the scheduler (dynamic priorities, but 
perhaps more) -- but what would produce the script?  How do you turn 
user feedback automatically into better rules?  But at the very least, 
it could speed up development by making scheduler behavior dynamically 
programmable.  If a priority inversion occurs and you stop the kernel to 
examine it, the AI engine could report to you what combination of rules 
were used to cause that condition.  You then dynamically change the 
rules and observe the effects.

I have huge gaps in my knowledge of AI, so I'm hoping some LKML members 
who are experts on this will engage in this discussion.

I think use of AI could be applied to the development of MANY parts of 
the kernel.  Obviously, the I/O scheduler could benefit.  But what about 
intelligently dealing with failure conditions?

Maybe AI could be useful in a running kernel, at least as an observer. 
I read an article about self-correcting systems in space craft.  There 
is the logic of the system, and then there is an AI model of it.  When 
some component fails to operate properly or the system behaves in an 
unexpected manner, the "model" finds a way to work around the problem. 
This kind of redundancy in a kernel being debugged could be invaluable. 
  In a deployment kernel, it could exist at a reduced level of 
sophistocation.

Another freaky idea is that large parts of the kernel could be rewritten 
in the heuristic language and interpreted during debugging and then 
compiled for release.

Also, some logic which is not computationally intensive could be always 
interpreted because the size of the interpretor plus the size of the 
pcode would be smaller than the size of the object code for the compiled 
version.  This would not be for performance-critical logic in a deployed 
system.

Ok, I know I'm going too far.  Right now, the best application would be 
the process scheduler, but we should start thinking about ways of making 
the system "self aware" and "self correcting" so that when the model 
observes the logic to misbehave, detailed information can be produced 
for debugging purposes.

Naturally, I am interested in contributing to this, but some of what I 
will have to learn to participate will come out of ensuing discussions. 
  I have a lot to learn, but I think if these ideas are valuable, others 
who already know enough will start to do something with them.

