Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264625AbUEUWxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264625AbUEUWxl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 18:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264828AbUEUWwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 18:52:25 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:58829 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S265117AbUEUWra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 18:47:30 -0400
Message-ID: <2124.128.150.143.219.1085064414.squirrel@webmail.seven4sky.com>
In-Reply-To: <40AC67F8.5010307@cs.up.ac.za>
References: <40A9E239.4010909@cs.up.ac.za>
    <1231.128.150.143.219.1084982960.squirrel@webmail.seven4sky.com>
    <40AC67F8.5010307@cs.up.ac.za>
Date: Thu, 20 May 2004 10:46:54 -0400 (EDT)
Subject: Re: NFS deadlock
From: "Sam Gill" <samg@seven4sky.com>
To: "Jaco Kroon" <jkroon@cs.up.ac.za>
Cc: samg@seven4sky.com, linux-kernel@vger.kernel.org
Reply-To: samg@seven4sky.com
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jaco,

sysstat is a package on debian, but includes the
sar utilities

such as sadc.

creates a directory in
redhat: /var/log/sa
debian: /var/log/sysstat

it captures statistics on the boxes its installed on
and saves them to a file saXX where XX is the day.

once you get the sar files, a cron job usually generates
a sar file sarXX, which you can then manually read, and it
will give you statictics about ever 15minutes. you can also
graph these numbers, on which I have been working on a program to
do this, but it is not finished quite yet.

You can change the frequency(cron), and manually generate the
sarXX graphs. It helped me diagnosis the situation, of a couple
failing computers. You have to know how to interpret the graphs,
but if you send me the saXX or sarXX files I can decode them for you.

I am planning on taking the project open-source, but I am not there
quite yet.

thanks,
 -sam








> Oh, sorry.
>
> The one box at home is running 2.6.5 currently with the intent of
> upgrading to 2.6.6 as soon as I can find the time.  It is using an ext3
> file system underlying.  The same goes to the single client it serves to.
>
> The one at the office that serves up to a hundred or so clients
> currently runs 2.6.4 with a patch for the dpt_i2o driver, it has an ext3
> partition but the one being served up via nfs is reiserfs.  The clients
> are running 2.6.5 at the moment (anything between 0 and 320 clients max
> at any time, usually between 20 and 50 clients depending on lab usage).
> The other server is using 2.4.24 (waiting for the dpt_i2o driver in the
> 2.6 kernel) with ext3 file systems and once again reiserfs for the nfs
> exported part of the file system.  Variety of clients in this case, from
> 2.4.20 kernels, right through to 2.6.6 kernels.
>
> The machine that died yesterday is also running a 2.6.5 kernel, ext3
> file system.  It's two clients is the first of the two servers above and
> the other runs kernel 2.6.6 as well.
>
> What affects the regulularity of the crashes seems to be the load placed
> on it by clients.  In my case at home the client is considerably faster
> that the server, which will enforce a relatively high load.  I wish I
> had more time to check this out. I'm suspecting some kind of race
> condition that gets triggered by either heavy system load or a heavy
> skew between speeds on the client/server.  I might be totally wrong
> though ...
>
> Transfers in our case is always between linus and linux (at least as far
> as we can control it, we are not aware of any other clients and would
> probably manage to get such a person expelled should we find him).
>
> The client lock-ups we've experienced as well.  It eventually times out
> after a *long* time, we usually bounce the server before that happens.
> This can be explained and is in my oppinion quite normal.
>
> What does sysstat and sar do?  How can I use them to analyse the problem?
>
> Jaco
>
> samg@seven4sky.com wrote:
>
>>Jaco,
>>
>>How are your boxes locking up, I have nfs in use every day,
>>does rpc die?
>>
>>what kernel are you using?
>>and are you transfering linux to linux, or to some other platform.
>>
>>The only time I had problems was when my client locked up
>>because I disconnected the server, and it hung the client,
>>the only solution (based on the way I connected), was to reboot.
>>To make matters worse, I rean a script that used du every day, and
>>so there were 12+ instances of du, all trying to run about.
>>
>>I would suggest using a program like sysstat, or sar, to help you
>>analyse the issues at hand.
>>
>> -sam
>>
>>
>>
>>>Hello there
>>>
>>>I've once again got problems with the kernel locking up.  I'm now
>>>convinced that it has something to do with NFS.
>>>
>>>Previously weve had 2 machines that locked up, plus my one at home,
>>>resulting in three machines.  Sometimes they would recover by themselves
>>>after some time, other times they could be left for 2 days or so without
>>>recovering.  All three of these use NFS to export files to other
>>>machines, it's the only thing we can find they have in common, other
>>>that x86 architecture, but then other machines would be dying as well.
>>>It should be noted that none of these runs on the newest hardware, but
>>>that should not matter, neither does any of our other servers.  We have
>>>a 3rd NFS server, which doesn't take nearly as heavy load via NFS.  I've
>>>been wondering why it hasn't locked up either, and this morning (right
>>>now in fact) it has decided that it is it's turn and is currently
>>>unusable.
>>>
>>>If anybody else is experiencing similar problems, or have possible work
>>>arounds, it would be appreciated if you could share your knowledge.
>>>
>>>Jaco
>>>
>>>===========================================
>>>This message and attachments are subject to a disclaimer. Please refer
>>> to
>>>www.it.up.ac.za/documentation/governance/disclaimer/ for full details.
>>>Hierdie boodskap en aanhangsels is aan 'n vrywaringsklousule onderhewig.
>>>Volledige besonderhede is by
>>>www.it.up.ac.za/documentation/governance/disclaimer/ beskikbaar.
>>>===========================================
>>>
>>>
>>>
>>>
>>
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel"
>> in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
>>
>>
>
> --
> "The strength of the Constitution lies entirely in the determination of
> each
> citizen to defend it.  Only if every single citizen feels duty bound to do
> his share in this defense are the constitutional rights secure."
> -- Albert Einstein
> ===========================================
> This message and attachments are subject to a disclaimer. Please refer to
> www.it.up.ac.za/documentation/governance/disclaimer/ for full details.
> Hierdie boodskap en aanhangsels is aan 'n vrywaringsklousule onderhewig.
> Volledige besonderhede is by
> www.it.up.ac.za/documentation/governance/disclaimer/ beskikbaar.
> ===========================================
>
>

