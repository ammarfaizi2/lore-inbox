Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132689AbRDBLot>; Mon, 2 Apr 2001 07:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132688AbRDBLoj>; Mon, 2 Apr 2001 07:44:39 -0400
Received: from mx01.uni-tuebingen.de ([134.2.3.11]:46343 "EHLO
	mx01.uni-tuebingen.de") by vger.kernel.org with ESMTP
	id <S132689AbRDBLoa>; Mon, 2 Apr 2001 07:44:30 -0400
Date: Mon, 2 Apr 2001 13:42:47 +0200 (CEST)
From: Richard Guenther <rguenth@tat.physik.uni-tuebingen.de>
To: Dennis Noordsij <dennis.noordsij@wiral.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: pthreads & fork & execve
In-Reply-To: <01033016225700.00409@dennis>
Message-ID: <Pine.LNX.4.21.0104021338320.8447-100000@bellatrix.tat.physik.uni-tuebingen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I tracked this down to a corrupt jumptable somewhere in the pthreads
part of the libc (didnt have the source handy at that time, though). So
I think this is a libc bug (version does not matter) - I even did a
followup to a similar bug in the libc gnats database (I think I should
have opened a new one, though...). But I failed to construct a "simple"
testcase showing the bug (We use rather large amount of threads and
in one or two doing popen() calls - or handcrafted fork() && execv(),
the SIGSEGV is during fork()).

I stopped trying to find out what is going on as this feature is not
essential (but maybe useful in the future). So I suggest you build a
libc from source with debugging on and trace it down to the actual
libc problem - or better try to isolate a simple testcase.

I like to hear from the results :)

Richard.

On Fri, 30 Mar 2001, Dennis Noordsij wrote:

> Hi,
> 
> I have question regarding use of pthreads, forks and execve's which appears 
> to not work very well :-) First let me explain the reasoning though
> 
> We have an app that launches a few other apps and keeps track of their 
> status, resource consumption etc. If one of the apps crashes, it is restarted 
> according to certain parameters.
> 
> The app uses pthreads, and it's method of (re)starting an application is 
> forking and calling execve. 
> 
> It works fine for all-but-one other app, which core dumps when started this 
> way (from the commandline it works fine) and the core only traces back to  
> int main(int argc, char **argv). It uses both pthreads and -ldl for plugin 
> handling. 
> 
> We have tried changing the linking order (i.e. -ldl -lpthread, -lpthread, 
> -ldl, etc), and even execv'ing a shell script that starts a shell script that 
> starts the app - result is the same, instant core without even running.
> 
> I can see who forks together with threads and execve's are a messy 
> combination, and a better solution altogether to our approach is appreciated 
> just as much as a way to make the current solution work :-)
> 
> We have tested both kernels 2.4.2 and 2.2.18. 
> 
> We have tried on different systems, different hardware and slightly different 
> distributions (debian potato, unstable, etc).
> 
> To sum up: using a pthreaded app to launch another pthreaded app by means of 
> forking and exec(ve)'ng makes the second app core immediately, (at entering 
> main). What to do?
> 
> Kind regards, and thanks for any help
> Dennis Noordsij
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

--
Richard Guenther <richard.guenther@uni-tuebingen.de>
WWW: http://www.tat.physik.uni-tuebingen.de/~rguenth/
The GLAME Project: http://www.glame.de/

