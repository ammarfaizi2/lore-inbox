Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287630AbSAHEAp>; Mon, 7 Jan 2002 23:00:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287631AbSAHEAg>; Mon, 7 Jan 2002 23:00:36 -0500
Received: from mail2.mx.voyager.net ([216.93.66.201]:13838 "EHLO
	mail2.mx.voyager.net") by vger.kernel.org with ESMTP
	id <S287630AbSAHEA1>; Mon, 7 Jan 2002 23:00:27 -0500
Message-ID: <3C3A6EE3.433BAF36@megsinet.net>
Date: Mon, 07 Jan 2002 22:00:35 -0600
From: "M.H.VanLeeuwen" <vanl@megsinet.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: riel@conectiva.com.br
CC: linux-kernel@vger.kernel.org, skraw@ithnet.com, andrea@suse.de
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Content-Type: multipart/mixed;
 boundary="------------4A7E69D3094B4231AFBD906C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------4A7E69D3094B4231AFBD906C
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Mon, 7 Jan 2002 00:22:09 -0200 (BRST) 
Rik van Riel <riel@conectiva.com.br> wrote: 

> On Sun, 6 Jan 2002, Rik van Riel wrote: 
> > On Sat, 5 Jan 2002, Stephan von Krawczynski wrote: 
> > 
> > > I am pretty impressed by Martins test case where merely all VM patches 
> > > fail with the exception of his own :-) 
> > 
> > No big wonder if both -aa and -rmap only get tested without swap ;) 
> 
> To be clear ... -aa and -rmap should of course also work 
> nicely without swap, no excuses for the bad behaviour 
> shown in Martin's test, but at the moment they simply 
> don't seem tuned for it. 

Hi Rik,

My original goal was to find a VM that worked well w/o swap, not to show how each
one acted with and without swap.  Failing to find what I thought satisfactory I
started my venture into VM by grepping the source for "Out of Memory:" and worked
backwards from there not so very too long ago...

I did not swap test any VM until asked how my patch benched w/ respect to
stock kernel w/ swap; others weren't left out intentionally I just never was asked.

Now that you "implied ;)" that it would be nice to see what other VM solutions look
like with my test case i've attached an updated "boring column of numbers".

Here is how I would rank current VM options w/ respect to the _one_ test case I run.
(Stephan has asked for an NFS server variant w/ my patch but I haven't tested it yet)

           1st     2nd   3rd     4th  
w/o swap   MH      AA   STOCK    RMAP  (ranked on VM pressure)
w/  swap   AA     STOCK   MH     RMAP  (ranked on sys time)

Observations:

a. rmap 10c, failed earlier than stock kernel thus doesn't qualify for use in my "no
   swap" systems and it is still undergoing change and isn't mainline kernel yet; will
   revisit at intervals.
b. rc2aa2, while much better than stock has unexpected behaviour(s) I didn't like.
   Namely, the konsole window running the tests was gone and KDE task bar were missing
   as well as some other windows and there was no indication by the kernel these
   processes were killed, only "VM: killing process cc1" and a few 0 order allocation
   failures (or something like that) at the end of the test.
c. mh patch probably doesn't swap enough but thus far there have been no bad reports
   that can be directly attributed to this rather small change to vmscan.c 
   1. it works well under extreme VM pressure
   2. it's performance is on par with the stock kernel and aa2

I glanced at rc2aa2 and it seems to be doing essentially what my patch does with a _lot_
of extra knobs some of which I don't like and I think I know why rc2aa2 doesn't perform
quite as well under extreme pressure but I don't have the luxury of time to [dis]prove
my ideas yet.

Haven't looked at rmap code yet...

Martin
--------------4A7E69D3094B4231AFBD906C
Content-Type: application/octet-stream;
 name="build.stats"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="build.stats"

U3lzdGVtOiBTTVAgNDY2IENlbGVyb24gMTkyTSBSQU0KCkVhY2ggcnVuIGFmdGVyIGNsZWFu
ICYgY2FjaGUgYnVpbGRzIGhhcyAxIG1vcmUgc2V0aWF0aG9tZSBjbGllbnQgcnVubmluZyB1
cHRvIGEKbWF4IGlmIDggc2V0aSBjbGllbnRzLiAgTm8sIHRoaXMgaXNuJ3QgbXkgbm9ybWFs
IHdheSBvZiBydW5uaW5nIHNldGlhdGhvbWUsIGJ1dAplYWNoIGluc3RhbmNlIHVzZXMgYSBu
aWNlIGNodW5rIG9mIG1lbW9yeS4KCk5vdGU6IHRoaXMgaXMgYSBzaW5nbGUgcnVuIGZvciBl
YWNoIG9mIHRoZSBjb2x1bW5zIHNvIHJlc3VsdHMgc2hvdyBmb3IgdGhlCmxvYWQgSSB3YXMg
cnVubmluZyB0aGUgbnVtYmVyIGFyZSBub3Qgc2lnbmlmaWNhbnRseSBkaWZmZXJlbnQuCgpP
YnNlcnZhdGlvbnM6IAoKYS4gcm1hcCAxMGMsIGZhaWxlZCBlYXJsaWVyIHRoYW4gc3RvY2sg
a2VybmVsIHRodXMgZG9lc24ndCBxdWFsaWZ5IGZvciB1c2UgaW4gbXkgIm5vIHN3YXAiIHN5
c3RlbXMKYi4gcmMyYWEyLCB3aGlsZSBtdWNoIGJldHRlciB0aGFuIHN0b2NrIGhhcyB1bmV4
cGVjdGVkIGJlaGF2aW91cihzKSBJIGRpZG4ndCBsaWtlLiAgbmFtZWx5LCB0aGUKICAga29u
c29sZSB3aW5kb3cgcnVubmluZyB0aGUgdGVzdHMgd2FzIGdvbmUgYW5kIEtERSB0YXNrIGJh
ciB3ZXJlIG1pc3NpbmcgYXMgd2VsbCBhcyBzb21lIG90aGVyCiAgIHdpbmRvd3MgYW5kIHRo
ZXJlIHdhcyBubyBpbmRpY2F0aW9uIGJ5IHRoZSBrZXJuZWwgd2h5IHRoZXNlIHByb2Nlc3Nl
cyB3ZXJlIGtpbGxlZC4KCgogICAgICAgICAgICAgIFNUT0NLIEtFUk5FTCAgIE1IIEtFUk5F
TCAgICAgICBTVE9DSyAgICAgICAgTUggS0VSTkVMICAgIFJNQVAgMTBjICAgICAgIFJNQVAg
MTBjICAgICBSQzJBQTIgICAgIFJDMkFBMgogICAgICAgICAgICAgIChubyBzd2FwKSAgICAg
IChubyBzd2FwKSAgICAgIFcvIFNXQVAgICAgICAgVy8gU1dBUCAgICAgIChubyBzd2FwKSAg
ICAgIFcvIFNXQVAgICAgIChubyBzd2FwKSAgIFcvIFNXQVAKCkNMRUFOCkJVSUxEICAgcmVh
bCAgIDdtMTkuNDI4cyAgICAgN20xOS41NDZzICAgICA3bTI2Ljg1MnMgICAgIDdtMjYuMjU2
cyAgICA3bTQ2Ljc2MHMgICAgIDdtMzQuNzM1cyAgICAgN20xNy42OThzICAgN20yOS43MTRz
CiAgICAgICAgdXNlciAgMTJtNTMuNjQwcyAgICAxMm01MC41NTBzICAgIDEybTUzLjc0MHMg
ICAgMTJtNDcuMTEwcyAgICAxM20yLjQyMHMgICAgMTJtNTMuMjEwcyAgICAxMm0zMy40NDBz
ICAxMm01OS4xNDBzCiAgICAgICAgc3lzICAgIDBtNDcuODkwcyAgICAgMG01NC45NjBzICAg
ICAwbTU4LjgxMHMgICAgICAxbTEuMDkwcyAgICAgMW03Ljg5MHMgICAgICAxbTAuNjUwcyAg
ICAgMG01My43OTBzICAgMG01OC4yNzBzCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgMS4xTSBzd3AgICAgICAgIDBNIHN3cCAgICAgICAgICAgICAgICAg
ICAgIDBNIHN3cCAgICAgICAgICAgICAgICAgICAgME0gc3dwCgpDQUNIRQpCVUlMRCAgIHJl
YWwgICAgN20zLjgyM3MgICAgICA3bTMuNTIwcyAgICAgIDdtNC4wNDBzICAgICAgN200LjI2
NnMgICAgN20xNi4zODZzICAgICA3bTEzLjEzOHMgICAgICA3bTMuMjA5cyAgICA3bTYuMTg3
cwogICAgICAgIHVzZXIgIDEybTQ3LjcxMHMgICAgMTJtNDkuMTEwcyAgICAxMm00Ny42NDBz
ICAgIDEybTQwLjEyMHMgICAxMm01Ni4zOTBzICAgIDEybTUzLjMwMHMgICAgMTJtNDYuMjAw
cyAgMTJtNTUuMjMwcwogICAgICAgIHN5cyAgICAwbTQ2LjY2MHMgICAgIDBtNDYuMjcwcyAg
ICAgMG00Ny40ODBzICAgICAwbTUxLjQ0MHMgICAgMG01NS4yMDBzICAgICAwbTU1LjM5MHMg
ICAgIDBtNDYuNDUwcyAgIDBtNDguMjkwcwogICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIDEuMU0gc3dwICAgICAgICAwTSBzd3AgICAgICAgICAgICAgICAg
ICAgIDBNIHN3cCAgICAgICAgICAgICAgICAgICAgIDBNIHN3cAoKU0VUSSAxCiAgICAgICAg
cmVhbCAgIDltNTEuNjUycyAgICAgOW01MC42MDFzICAgICA5bTUzLjE1M3MgICAgIDltNTMu
NjY4cyAgICAxMG04LjkzM3MgICAgIDEwbTYuMDMzcyAgICAgOW01MS45NTRzICAgOW01NS4z
NDBzCiAgICAgICAgdXNlciAgIDEzbTUuMjUwcyAgICAgMTNtNC40MjBzICAgICAxM201LjA0
MHMgICAgIDEzbTQuNDcwcyAgIDEzbTE2LjA0MHMgICAgMTNtMTQuMjUwcyAgICAxM20xOS4z
MTBzICAxMm01Ny42MDBzCiAgICAgICAgc3lzICAgIDBtNDkuMDIwcyAgICAgMG01MC40NjBz
ICAgICAwbTUxLjE5MHMgICAgIDBtNTAuNTgwcyAgICAgMW0xLjA4MHMgICAgICAxbTAuOTUw
cyAgICAgMG01MS44MDBzICAgMG00OS4wNDBzCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgMS4xTSBzd3AgICAgICAgIDBNIHN3cCAgICAgICAgICAgICAg
ICAgICAwLjRNIHN3cCAgICAgICAgICAgICAgICAgICAgME0gc3dwCgpTRVRJIDIKICAgICAg
ICByZWFsICAgMTNtOS43MzBzICAgICAxM203LjcxOXMgICAgIDEzbTQuMjc5cyAgICAgMTNt
NC43NjhzICAgIE9PTSBLSUxMRUQgICAxM20xNC42NzBzICAgIDEzbTEzLjE4MXMgIDEzbTE1
LjE4NnMKICAgICAgICB1c2VyICAxM20xNi44MTBzICAgIDEzbTE1LjE1MHMgICAgMTNtMTUu
OTUwcyAgICAxM20xMy40MDBzICAgICBrZGVpbml0ICAgICAxM20xNS41MjBzICAgICAxM20w
LjY0MHMgICAxM204LjY2MHMKICAgICAgICBzeXMgICAgMG01MC44ODBzICAgICAwbTUwLjQ2
MHMgICAgIDBtNTAuOTMwcyAgICAgMG01Mi41MjBzICAgICAgICAgICAgICAgICAgIDFtMS4y
MDBzICAgICAwbTQ4Ljg0MHMgICAwbTUxLjA2MHMKICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICA1LjhNIHN3cCAgICAgIDEuOU0gc3dwICAgICAgICAgICAg
ICAgICAgIDAuOU0gc3dwICAgICAgICAgICAgICAgICAgMS4zTSBzd3AKClNFVEkgMwogICAg
ICAgIHJlYWwgIDE1bTQ5LjMzMXMgICAgMTVtNDEuMjY0cyAgICAxNW00MC44MjhzICAgIDE1
bTQ1LjU1MXMgICAgIE5BICAgICAgICAgIDE1bTI2LjExN3MgICAgMTVtNTIuMjAycyAgMTVt
NTYuMzc4cwogICAgICAgIHVzZXIgIDEzbTIyLjE1MHMgICAgMTNtMjEuNTYwcyAgICAxM20x
NC4zOTBzICAgIDEzbTIwLjc5MHMgICAgICAgICAgICAgICAgIDEybTU3LjI5MHMgICAgMTNt
MjEuNjUwcyAgMTNtMTQuNTYwcwogICAgICAgIHN5cyAgICAwbTQ5LjI1MHMgICAgIDBtNDku
OTEwcyAgICAgMG00OS44NTBzICAgICAwbTUwLjkxMHMgICAgICAgICAgICAgICAgICAwbTU2
LjM3MHMgICAgIDBtNTIuNDEwcyAgIDBtNTEuNzUwcwogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgMTYuMk0gc3dwICAgICAgMy4xTSBzd3AgICAgICAgICAg
ICAgICAgICAgMS4xTSBzd3AgICAgICAgICAgICAgICAgICA4LjNNIHN3cAoKU0VUSSA0CiAg
ICAgICAgcmVhbCAgIE9PTSBLSUxMRUQgICAgMTltOC40MzVzICAgICAxOW01LjU4NHMgICAg
IDE5bTMuNjE4cyAgICAgTkEgICAgICAgICAgMThtMzEuNTEwcyAgICAxOW0yNC4wODFzICAx
OW0yNC43OTNzCiAgICAgICAgdXNlciAgIGtkZWluaXQgICAgICAxM20yNC41NzBzICAgIDEz
bTI0LjAwMHMgICAgMTNtMjIuNTIwcyAgICAgICAgICAgICAgICAgMTJtNTUuMTUwcyAgICAx
M20yMC4xNDBzICAxM20yMi45NTBzCiAgICAgICAgc3lzICAgICAgICAgICAgICAgICAgMG01
MS40MzBzICAgICAwbTUwLjMyMHMgICAgIDBtNTEuMzkwcyAgICAgICAgICAgICAgICAgIDBt
NTYuODEwcyAgICAgMG01Mi44MTBzICAgMG01MS41ODBzCiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAxOC43TSBzd3AgICAgICA4LjNNIHN3cCAgICAgICAg
ICAgICAgICAgIDE0LjBNIHN3cCAgICAgICAgICAgICAgICAgMTMuNU0gc3dwCgpTRVRJIDUK
ICAgICAgICByZWFsICAgTkEgICAgICAgICAgIDIxbTM1LjUxNXMgICAgMjFtNDguNTQzcyAg
ICAgMjJtMC4yNDBzICAgICBOQSAgICAgICAgICAgMjFtNi4wMTdzICAgIDIybTEwLjAzM3Mg
IDIybTExLjQyM3MKICAgICAgICB1c2VyICAgICAgICAgICAgICAgICAxM205LjY4MHMgICAg
MTNtMjIuMDMwcyAgICAxM20yOC44MjBzICAgICAgICAgICAgICAgICAxMm01My43ODBzICAg
IDEzbTEyLjc0MHMgIDEzbTIxLjcxMHMKICAgICAgICBzeXMgICAgICAgICAgICAgICAgICAw
bTQ5LjkxMHMgICAgIDBtNTAuODUwcyAgICAgMG01Mi4yNzBzICAgICAgICAgICAgICAgICAg
MG01NS4zOTBzICAgICAwbTUyLjE4MHMgICAwbTUxLjAwMHMKICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIDMxLjdNIHN3cCAgICAgMTEuM00gc3dwICAgICAg
ICAgICAgICAgICAgMzEuM00gc3dwICAgICAgICAgICAgICAgICAyNS41TSBzd3AKClNFVEkg
NgogICAgICAgIHJlYWwgICBOQSAgICAgICAgICAgMjRtMzcuMTY3cyAgICAgMjVtNS4yNDRz
ICAgIDI1bTEzLjQyOXMgICAgIE5BICAgICAgICAgIDI0bTMxLjc1NHMgICAgMjVtMjUuNjg2
cyAgMjVtMzguMDA4cwogICAgICAgIHVzZXIgICAgICAgICAgICAgICAgIDEzbTcuNjUwcyAg
ICAxM20yNi41OTBzICAgIDEzbTMyLjY0MHMgICAgICAgICAgICAgICAgICAxM202LjE0MHMg
ICAgMTNtMjEuNjEwcyAgMTNtMzIuOTkwcwogICAgICAgIHN5cyAgICAgICAgICAgICAgICAg
IDBtNTEuMzkwcyAgICAgMG01MS4yNjBzICAgICAwbTUyLjc5MHMgICAgICAgICAgICAgICAg
ICAwbTU3LjAzMHMgICAgIDBtNDkuNTkwcyAgIDBtNTEuMzQwcwogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgMzUuM00gc3dwICAgICAxNy4xTSBzd3AgICAg
ICAgICAgICAgICAgICAzMS42TSBzd3AgICAgICAgICAgICAgICAgIDM1LjJNIHN3cAoKU0VU
SSA3CiAgICAgICAgcmVhbCAgIE5BICAgICAgICAgICAyOG00MC40NDZzICAgICAyOG0zLjYx
MnMgICAgMjhtMTIuOTgxcyAgICAgTkEgICAgICAgICAgIDI3bTU0LjAyM3MgIFZNOiBraWxs
aW5nICAyOG0yOC4xNjBzCiAgICAgICAgdXNlciAgICAgICAgICAgICAgICAxM20xNi40NjBz
ICAgIDEzbTI2LjEzMHMgICAgMTNtMzEuNTIwcyAgICAgICAgICAgICAgICAgIDEzbTE5LjA1
MHMgIHByb2Nlc3MgY2MxICAxM20yNS4zODBzCiAgICAgICAgc3lzICAgICAgICAgICAgICAg
ICAgMG01Ny45NDBzICAgICAwbTUyLjUxMHMgICAgIDBtNTMuNTcwcyAgICAgICAgICAgICAg
ICAgICAwbTU4Ljk3MHMgICAgICAgICAgICAgICAgMG01MC4yNDBzCiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAzOC44TSBzd3AgICAgIDI1LjRNIHN3cCAg
ICAgICAgICAgICAgICAgICAzNi41TSBzd3AgICAgICAgICAgICAgICAgMzguN00gc3dwCgpT
RVRJIDgKICAgICAgICByZWFsICAgTkEgICAgICAgICAgIDI5bTMxLjc0M3MgICAgMzFtMTYu
Mjc1cyAgICAzMm0yOS41MzRzICAgICBOQSAgICAgICAgICAgMzFtMjguMjIzcyAgICBOQSAg
ICAgICAgMzFtMzcuNTg0cwogICAgICAgIHVzZXIgICAgICAgICAgICAgICAgMTNtMzcuNjEw
cyAgICAxM20yNy43NDBzICAgIDEzbTMzLjYzMHMgICAgICAgICAgICAgICAgICAxM20yOC43
NDBzICAgICAgICAgICAgICAxM20yOC4xOTBzCiAgICAgICAgc3lzICAgICAgICAgICAgICAg
ICAgIDFtNC40NTBzICAgICAwbTUyLjEwMHMgICAgIDBtNTQuMTQwcyAgICAgICAgICAgICAg
ICAgICAgMW0wLjYzMHMgICAgICAgICAgICAgICAwbTUwLjkxMHMKICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIDQxLjVNIHN3cCAgICAgNDkuN00gc3dwICAg
ICAgICAgICAgICAgICAgIDUzLjhNIHN3cCAgICAgICAgICAgICAgIDQxLjJNIHN3cAo=
--------------4A7E69D3094B4231AFBD906C--

