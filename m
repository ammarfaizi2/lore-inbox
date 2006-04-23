Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751424AbWDWQih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbWDWQih (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 12:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbWDWQig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 12:38:36 -0400
Received: from nz-out-0102.google.com ([64.233.162.193]:61981 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751423AbWDWQif convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 12:38:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UKOrlt8vH5rSUn+DfY9+/I4MIsKQUaEQAa46ZWtakNsu7Ns2/FACdVauPYPJodqzhhrGairDkFjtnmfLWoST1v+V/k4/k7tLJbefmUCYIH/SnEZ5W1G/6X2tAd9H3e/0LslJivYIc62EIgow2gmS4tZe0f5uMqsYr8ae0sFV1LM=
Message-ID: <a36005b50604230938k2f52186ek477850b3e3a7192@mail.gmail.com>
Date: Sun, 23 Apr 2006 09:38:34 -0700
From: "Ulrich Drepper" <drepper@gmail.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Subject: Re: [ANNOUNCE] Release Digsig 1.5: kernel module for run-time authentication of binaries
Cc: "Makan Pourzandi" <Makan.Pourzandi@ericsson.com>,
       linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
       "Serue Hallyen" <serue@us.ibm.com>,
       "Axelle Apvrille" <axelle_apvrille@rc1.vip.ukl.yahoo.com>,
       "disec-devel@lists.sourceforge.net" 
	<disec-devel@lists.sourceforge.net>
In-Reply-To: <1145794712.3131.10.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4448AC62.6090303@ericsson.com>
	 <1145794712.3131.10.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/23/06, Arjan van de Ven <arjan@infradead.org> wrote:
> does this also prevent people writing their own elf loader in a bit of
> perl and just mmap the code ?

You will never get 100% protection from a mechanism like signed
binaries.  What you can get in collaboration with other protections
like SELinux is another layer of security.  That's good IMO.  Not
being able to slide in modified and substituted binaries which then
would be marked to get certain privileges is a plus.

But preventing every type of code loading or generation at userlevel
cannot be prevented this way.  Just look at the code proposed to deal
with execmem problems in
http://people.redhat.com/drepper/selinux-mem.html.  This is with all
the SELinux mechanisms in place and activated.  You can prevent by
using the noexec mount option for every writable filesystem. But this
is so far not possible for ordinary machines.  There are widely used
programs out there which need to dynamically generate code.

Signed binaries are therefore a complete solution only for a very
limited number of situation.  For embedded systems I see this but here
we also have the "Tivo problem" where devices are built on top of
Linux and people are still prevented from extending/modifying them. 
Beside that there is potentially some locked down machines with
limited functionality which can use it (e.g., DMZ servers, but they
mustn't use Java etc).

So, I do not think that signed binaries have a big upside.  And they
have a potential big downside.  The better approach to ensure that
SELinux, for instance, doesn't change the labels for incorrect
binaries is to integrate restorecon etc with the package manager and
have functionality in the package manager to recognize incorrect
binaries.  This might again mean signed binaries although I imagine
the current signed hash values work fine, too.  Although we might want
to go from MD5 to SHA256.

I have been working on signed binaries at some point myself but
abandoned it after realizing that it realistically only can be
misused.  If I'd have a vote I'd keep this stuff out of the kernel.
