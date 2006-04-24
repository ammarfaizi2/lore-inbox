Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751236AbWDXUZf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbWDXUZf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 16:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbWDXUZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 16:25:34 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:51973 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1751236AbWDXUZd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 16:25:33 -0400
To: "Ulrich Drepper" <drepper@gmail.com>
Cc: "Arjan van de Ven" <arjan@infradead.org>,
       "Makan Pourzandi" <Makan.Pourzandi@ericsson.com>,
       linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
       "Serue Hallyen" <serue@us.ibm.com>,
       "Axelle Apvrille" <axelle_apvrille@rc1.vip.ukl.yahoo.com>,
       "disec-devel@lists.sourceforge.net" 
	<disec-devel@lists.sourceforge.net>
Subject: Re: [ANNOUNCE] Release Digsig 1.5: kernel module for run-time authentication of binaries
References: <4448AC62.6090303@ericsson.com>
	<1145794712.3131.10.camel@laptopd505.fenrus.org>
	<a36005b50604230938k2f52186ek477850b3e3a7192@mail.gmail.com>
From: Nix <nix@esperi.org.uk>
X-Emacs: a Lisp interpreter masquerading as ... a Lisp interpreter!
Date: Mon, 24 Apr 2006 21:24:47 +0100
In-Reply-To: <a36005b50604230938k2f52186ek477850b3e3a7192@mail.gmail.com> (Ulrich Drepper's message of "23 Apr 2006 17:39:38 +0100")
Message-ID: <87psj6pvqo.fsf@hades.wkstn.nix>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Apr 2006, Ulrich Drepper prattled cheerily:
> On 4/23/06, Arjan van de Ven <arjan@infradead.org> wrote:
>> does this also prevent people writing their own elf loader in a bit of
>> perl and just mmap the code ?
> 
> You will never get 100% protection from a mechanism like signed
> binaries.  What you can get in collaboration with other protections
> like SELinux is another layer of security.  That's good IMO.  Not
> being able to slide in modified and substituted binaries which then
> would be marked to get certain privileges is a plus.

Of course in order to use it in conjunction with SELinux right now you
need LSM stacking, which is a nest of dragons in itself (if not used
very carefully stacking can weaken security rather than strengthening
it...)

> But preventing every type of code loading or generation at userlevel
> cannot be prevented this way.

Oh, indeed not. It's just a stopgap that blocks some (large) percentage
of script kiddy attacks that involve downloading binaries and then
executing them, or even compiling them on the spot (not that those are
as common these days).

> http://people.redhat.com/drepper/selinux-mem.html.  This is with all
> the SELinux mechanisms in place and activated.  You can prevent by
> using the noexec mount option for every writable filesystem. But this
> is so far not possible for ordinary machines.  There are widely used
> programs out there which need to dynamically generate code.

Yeah. I'll admit I've found signed binaries principally useful on
stripped-down firewalls and firewall UML instances. These boxes don't
tend to run, say, CLISP or SBCL or OpenOffice (at least if they do the
firewall maintainer needs shooting).

> Signed binaries are therefore a complete solution only for a very
> limited number of situation.

`Stripped-down firewalls' on its own is a big niche.

Combine it with SELinux, exec-shield, FORTIFY_SOURCE, -fstack-protector
and, say, a COWed filesystem read off a CD and reset with every boot,
and you start to get a bit less insecure than you would otherwise be.

>                              For embedded systems I see this but here
> we also have the "Tivo problem" where devices are built on top of
> Linux and people are still prevented from extending/modifying them. 

Yeah, that's nasty: but the inverse face is that, for instance, nobody
can compile a new binary on my firewall without access to a private key
kept on a CD which is not normally in the drive. Replace `not in the
drive' with `at a manufacturer's site locked securely away from the
user' and suddenly this security benefit becomes an attack on
freedom. But that doesn't mean that there's anything wrong with it *as a
security benefit*: I haven't tivoized myself entirely *because* I have
access to that key, but there's no way any software can possibly tell
that.

> Beside that there is potentially some locked down machines with
> limited functionality which can use it (e.g., DMZ servers, but they
> mustn't use Java etc).

Yes indeed.

> So, I do not think that signed binaries have a big upside.  And they
> have a potential big downside.

It's another hurdle for the bad guys to leap, and many will fall at the
wayside.

> I have been working on signed binaries at some point myself but
> abandoned it after realizing that it realistically only can be
> misused.  If I'd have a vote I'd keep this stuff out of the kernel.

Well, I'm using it, but I'd agree that the potential for misuse by the
tivos of this world is high. I don't know if it should go into mainline,
but let's not make it intentionally hard for it to exist
out-of-tree. It's useful to help professional paranoids sleep at
night. :)

(But, well, since the code *exists*, the tivos of this world can
*already* tivoize. I can't see what keeping it out would do, really.
I suppose it would increase the barrier for a would-be tivoizer.)

-- 
`On a scale of 1-10, X's "brokenness rating" is 1.1, but that's only
 because bringing Windows into the picture rescaled "brokenness" by
 a factor of 10.' --- Peter da Silva
