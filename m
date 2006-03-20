Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030564AbWCTWGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030564AbWCTWGu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 17:06:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030555AbWCTWGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 17:06:09 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:17165 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1030558AbWCTWFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 17:05:38 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C64C6A.1B56C5EF"
Subject: RE: [RFC, PATCH 0/24] VMI i386 Linux virtualization interface proposal
Date: Mon, 20 Mar 2006 14:03:23 -0800
Message-ID: <E7152B8C330AD042B484826CB1A4122F04565F@PA-EXCH01.vmware.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC, PATCH 0/24] VMI i386 Linux virtualization interface proposal
Thread-Index: AcZGx8rsEM1UmrRMRFCsTnPz1tA8rQFhapGQAAagfHA=
From: "Anne Holler" <anne@vmware.com>
To: "Anne Holler" <anne@vmware.com>, "Zach Amsden" <zach@vmware.com>,
       "Linus Torvalds" <torvalds@osdl.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Virtualization Mailing List" <virtualization@lists.osdl.org>,
       "Xen-devel" <xen-devel@lists.xensource.com>,
       "Andrew Morton" <akpm@osdl.org>, "Zach Amsden" <zach@vmware.com>,
       "Daniel Hecht" <dhecht@vmware.com>, "Daniel Arai" <arai@vmware.com>,
       "Pratap Subrahmanyam" <pratap@vmware.com>,
       "Christopher Li" <chrisl@vmware.com>,
       "Joshua LeVasseur" <jtl@ira.uka.de>, "Chris Wright" <chrisw@osdl.org>,
       "Rik Van Riel" <riel@redhat.com>, "Jyothy Reddy" <jreddy@vmware.com>,
       "Jack Lo" <jlo@vmware.com>, "Kip Macy" <kmacy@fsmware.com>,
       "Jan Beulich" <jbeulich@novell.com>,
       "Ky Srinivasan" <ksrinivasan@novell.com>,
       "Wim Coekaerts" <wim.coekaerts@oracle.com>,
       "Leendert van Doorn" <leendert@watson.ibm.com>,
       "Zach Amsden" <zach@vmware.com>
X-OriginalArrivalTime: 20 Mar 2006 22:03:24.0501 (UTC) FILETIME=[1BE71050:01C64C6A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C64C6A.1B56C5EF
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Apologies for resend: earlier email with html attachments was
 rejected.  Resending with txt attachments.]

>From: Zachary Amsden [mailto:zach@vmware.com]
>Sent: Monday, March 13, 2006 9:58 AM

>In OLS 2005, we described the work that we have been doing in VMware
>with respect a common interface for paravirtualization of Linux. We
>shared the general vision in Rik's virtualization BoF.

>This note is an update on our further work on the Virtual Machine
>Interface, VMI.  The patches provided have been tested on 2.6.16-rc6.
>We are currently recollecting performance information for the new -rc6
>kernel, but expect our numbers to match previous results, which showed
>no impact whatsoever on macro benchmarks, and nearly neglible impact
>on microbenchmarks.

Folks,

I'm a member of the performance team at VMware & I recently did a
round of testing measuring the performance of a set of benchmarks
on the following 2 linux variants, both running natively:
 1) 2.6.16-rc6 including VMI + 64MB hole
 2) 2.6.16-rc6 not including VMI + no 64MB hole
The intent was to measure the overhead of VMI calls on native runs.
Data was collected on both p4 & opteron boxes.  The workloads used
were dbench/1client, netperf/receive+send, UP+SMP kernel compile,
lmbench, & some VMware in-house kernel microbenchmarks.  The CPU(s)
were pegged for all workloads except netperf, for which I include
CPU utilization measurements.

Attached please find a text file presenting the benchmark results
collected in terms of ratio of 1) to 2), along with the raw scores
given in brackets.  System configurations & benchmark descriptions
are given at the end of the page; more details are available on
request.  Also attached for reference is a text file giving the
width of the 95% confidence interval around the mean of the scores
reported for each benchmark, expressed as a percentage of the mean.

The VMI-Native & Native scores for almost all workloads match
within the 95% confidence interval.  On the P4, only 4 workloads,
all lmbench microbenchmarks (forkproc,shproc,mmap,pagefault) were
outside the interval & the overheads (2%,1%,2%,1%, respectively)
were low.  The opteron microbenchmark data was a little more
ragged than the P4 in terms of variance, but it appears that only
a few lmbench microbenchmarks (forkproc,execproc,shproc) were
outside their confidence intervals and they show low overheads
(4%,3%,2%, respectively); our in-house segv & divzero seemed to
show measureable overheads as well (8%,9%).

-Regards, Anne Holler (anne@vmware.com)

------_=_NextPart_001_01C64C6A.1B56C5EF
Content-Type: text/plain;
	name="score.2.6.16-rc6.txt"
Content-Transfer-Encoding: base64
Content-Description: score.2.6.16-rc6.txt
Content-Disposition: attachment;
	filename="score.2.6.16-rc6.txt"

Mi42LjE2LXJjNiBUcmFuc3BhcmVudCBQYXJhdmlydHVhbGl6YXRpb24gUGVyZm9ybWFuY2UgU2Nv
cmVib2FyZDIuNi4xNi1yYzYgVHJhbnNwYXJlbnQgUGFyYXZpcnR1YWxpemF0aW9uIFBlcmZvcm1h
bmNlIFNjb3JlYm9hcmQNClVwZGF0ZWQ6IDAzLzIwLzIwMDYgKiBDb250YWN0OiBBbm5lIEhvbGxl
ciAoYW5uZUB2bXdhcmUuY29tKQ0KDQpUaHJvdWdocHV0IGJlbmNobWFya3MgLT4gSElHSEVSIElT
IEJFVFRFUiAtPiBIaWdoZXIgcmF0aW8gaXMgYmV0dGVyDQogICAgICAgICAgICAgICAgICAgICBQ
NCAgICAgICAgICAgICAgICAgIE9wdGVyb24gDQogICAgICAgICAgICAgICAgICAgICBWTUktTmF0
aXZlL05hdGl2ZSAgIFZNSS1OYXRpdmUvTmF0aXZlICAgQ29tbWVudHMNCiBEYmVuY2gNCiAgMWNs
aWVudCAgICAgICAgICAgIDEuMDAgWzMxMi8zMTFdICAgICAgMS4wMCBbNDI1LzQyNV0NCiBOZXRw
ZXJmDQogIFJlY2VpdmUgICAgICAgICAgICAxLjAwIFs5NDgvOTQ3XSAgICAgIDEuMDAgWzkzNy85
MzddICAgICAgQ3B1VXRpbDpQNChWTUk6NDMlLE50djo0MiUpO09wdGVyb24oVk1JOjM2JSxOdHY6
MzQlKQ0KICBTZW5kICAgICAgICAgICAgICAgMS4wMCBbOTM5LzkzOV0gICAgICAxLjAwIFs5Mzcv
OTM2XSAgICAgIENwdVV0aWw6UDQoVk1JOjI1JSxOdHY6MjUlKTtPcHRlcm9uKFZNSTo2MiUsTnR2
OjYwJSkNCg0KTGF0ZW5jeSBiZW5jaG1hcmtzIC0+IExPV0VSIElTIEJFVFRFUiAtPiBMb3dlciBy
YXRpbyBpcyBiZXR0ZXINCiAgICAgICAgICAgICAgICAgICAgIFA0ICAgICAgICAgICAgICAgICAg
T3B0ZXJvbiANCiAgICAgICAgICAgICAgICAgICAgIFZNSS1OYXRpdmUvTmF0aXZlICAgVk1JLU5h
dGl2ZS9OYXRpdmUgICBDb21tZW50cw0KIEtlcm5lbCBjb21waWxlDQogIFVQICAgICAgICAgICAg
ICAgICAxLjAwIFsyMjEvMjIwXSAgICAgIDEuMDAgWzEzMS8xMzFdDQogIFNNUC8yd2F5ICAgICAg
ICAgICAxLjAwIFsxMTcvMTE3XSAgICAgIDEuMDAgWzY3LzY3XQ0KIExtYmVuY2ggcHJvY2VzcyB0
aW1lIGxhdGVuY2llcw0KICBudWxsIGNhbGwgICAgICAgICAgMS4wMCBbMC4xNy8wLjE3XSAgICAx
LjAwIFswLjA4LzAuMDhdDQogIG51bGwgaS9vICAgICAgICAgICAxLjAwIFswLjI5LzAuMjldICAg
IDAuOTIgWzAuMjMvMC4yNV0gICAgb3B0ZXJvbjogd2lkZSBjb25maWRlbmNlIGludGVydmFsDQog
IHN0YXQgICAgICAgICAgICAgICAwLjk5IFsyLjE0LzIuMTZdICAgIDAuOTQgWzIuMjUvMi4zOV0g
ICAgb3B0ZXJvbjogb2RkLCAxJSBvdXRzaWRlIHdpZGUgY29uZmlkZW5jZSBpbnRlcnZhbA0KICBv
cGVuIGNsb3MgICAgICAgICAgMS4wMSBbMy4wMC8yLjk2XSAgICAwLjk4IFszLjE2LzMuMjRdDQog
IHNsY3QgVENQICAgICAgICAgICAxLjAwIFs4Ljg0LzguODNdICAgIDAuOTQgWzExLjgvMTIuNV0g
ICAgb3B0ZXJvbjogd2lkZSBjb25maWRlbmNlIGludGVydmFsDQogIHNpZyBpbnN0ICAgICAgICAg
ICAwLjk5IFswLjY4LzAuNjldICAgIDEuMDkgWzAuMzYvMC4zM10gICAgb3B0ZXJvbjogYmVzdCBp
cyAxLjAzIFswLjM0LzAuMzNdDQogIHNpZyBobmRsICAgICAgICAgICAwLjk5IFsyLjE5LzIuMjFd
ICAgIDEuMDUgWzEuMjAvMS4xNF0gICAgb3B0ZXJvbjogYmVzdCBpcyAxLjAyIFsxLjEzLzEuMTFd
DQogIGZvcmsgcHJvYyAgICAgICAgICAxLjAyIFsxMzcvMTM0XSAgICAgIDEuMDQgWzEwMC85Nl0N
CiAgZXhlYyBwcm9jICAgICAgICAgIDEuMDIgWzUzNi81MjVdICAgICAgMS4wMyBbMzA5LzMwMV0N
CiAgc2ggcHJvYyAgICAgICAgICAgIDEuMDEgWzMyMDQvMzE2OV0gICAgMS4wMiBbMTU1MS8xNTI4
XQ0KIExtYmVuY2ggY29udGV4dCBzd2l0Y2ggdGltZSBsYXRlbmNpZXMNCiAgMnAvMEsgICAgICAg
ICAgICAgIDEuMDAgWzIuODQvMi44NF0gICAgMS4xNCBbMC43NC8wLjY1XSAgICBvcHRlcm9uOiB3
aWRlIGNvbmZpZGVuY2UgaW50ZXJ2YWwNCiAgMnAvMTZLICAgICAgICAgICAgIDEuMDEgWzIuOTgv
Mi45NV0gICAgMC45MyBbMC43NC8wLjgwXSAgICBvcHRlcm9uOiB3aWRlIGNvbmZpZGVuY2UgaW50
ZXJ2YWwNCiAgMnAvNjRLICAgICAgICAgICAgIDEuMDIgWzMuMDYvMy4wMV0gICAgMS4wMCBbNC4x
OS80LjE4XQ0KICA4cC8xNksgICAgICAgICAgICAgMS4wMiBbMy4zMS8zLjI2XSAgICAwLjk3IFsx
Ljg2LzEuOTFdDQogIDhwLzY0SyAgICAgICAgICAgICAxLjAxIFszMC40LzMwLjBdICAgIDEuMDAg
WzQuMzMvNC4zNF0NCiAgMTZwLzE2SyAgICAgICAgICAgIDAuOTYgWzcuNzYvOC4wNl0gICAgMC45
NyBbMi4wMy8yLjEwXQ0KICAxNnAvNjRLICAgICAgICAgICAgMS4wMCBbNDEuNS80MS40XSAgICAx
LjAwIFsxNS45LzE1LjldDQogTG1iZW5jaCBzeXN0ZW0gbGF0ZW5jaWVzDQogIE1tYXAgICAgICAg
ICAgICAgICAxLjAyIFs2NjgxLzY1NDJdICAgIDEuMDAgWzM0NTIvMzQ0MV0NCiAgUHJvdCBGYXVs
dCAgICAgICAgIDEuMDYgWzAuOTIwLzAuODcyXSAgMS4wNyBbMC4xOTcvMC4xODRdICBwNCtvcHRl
cm9uOiB3aWRlIGNvbmZpZGVuY2UgaW50ZXJ2YWwNCiAgUGFnZSBGYXVsdCAgICAgICAgIDEuMDEg
WzIuMDY1LzIuMDUwXSAgMS4wMCBbMS4xMC8xLjEwXQ0KIEtlcm5lbCBNaWNyb2JlbmNobWFya3MN
CiAgZ2V0cHBpZCAgICAgICAgICAgIDEuMDAgWzEuNzAvMS43MF0gICAgMS4wMCBbMC44My8wLjgz
XQ0KICBzZWd2ICAgICAgICAgICAgICAgMC45OSBbNy4wNS83LjA5XSAgICAxLjA4IFsyLjk1LzIu
NzJdDQogIGZvcmt3YWl0biAgICAgICAgICAxLjAyIFszLjYwLzMuNTRdICAgIDEuMDUgWzIuNjEv
Mi40OF0NCiAgZGl2emVybyAgICAgICAgICAgIDAuOTkgWzUuNjgvNS43M10gICAgMS4wOSBbMi43
MS8yLjQ4XQ0KDQpTeXN0ZW0gQ29uZmlndXJhdGlvbnM6DQogUDQ6ICAgICAgQ1BVOiAyLjRHSHo7
IE1FTTogMTAyNE1COyBESVNLOiAxMEsgU0NTSTsgU2VydmVyK0NsaWVudCBOSUNzOiBJbnRlbCBl
MTAwMCBzZXJ2ZXIgYWRhcHRlcg0KIE9wdGVyb246IENQVTogMi4yR2h6OyBNRU06IDEwMjRNQjsg
RElTSzogMTBLIFNDU0k7IFNlcnZlcitDbGllbnQgTklDczogQnJvYWRjb20gTmV0WHRyZW1lIEJD
TTU3MDQNCiBVUCBrZXJuZWwgdXNlZCBmb3IgYWxsIHdvcmtsb2FkcyBleGNlcHQgU01QIGtlcm5l
bCBjb21waWxlDQoNCkJlbmNobWFyayBEZXNjcmlwdGlvbnM6DQogRGJlbmNoOiByZXBlYXQgTiB0
aW1lcyB1bnRpbCA5NSUgY29uZmlkZW5jZSBpbnRlcnZhbCA1JSBhcm91bmQgbWVhbjsgcmVwb3J0
IG1lYW4NCiAgdmVyc2lvbiAyLjAgcnVuIGFzICJ0aW1lIC4vZGJlbmNoIC1jIGNsaWVudF9wbGFp
bi50eHQgMSINCiBOZXRwZXJmOiBiZXN0IG9mIDUgcnVucw0KICBNZXNzYWdlU2l6ZTo4MTkyK1Nv
Y2tldFNpemU6NjU1MzY7IG5ldHBlcmYgLUggY2xpZW50LWlwIC1sIDYwIC10IFRDUF9TVFJFQU0N
CiBLZXJuZWwgY29tcGlsZTogYmVzdCBvZiAzIHJ1bnMNCiAgQnVpbGQgb2YgMi42LjExIGtlcm5l
bCB3L2djYyA0LjAuMiB2aWEgInRpbWUgbWFrZSAtaiAxNiBiekltYWdlIg0KIExtYmVuY2g6IGF2
ZXJhZ2Ugb2YgYmVzdCAxOCBvZiAzMCBydW5zDQogIHZlcnNpb24gMy4wLWE0OyBvYnRhaW5lZCBm
cm9tIHNvdXJjZWZvcmdlDQogS2VybmVsIG1pY3JvYmVuY2htYXJrczogYXZlcmFnZSBvZiBiZXN0
IDMgb2YgNSBydW5zDQogIGdldHBwaWQ6IGxvb3Agb2YgMTAgY2FsbHMgdG8gZ2V0cHBpZCwgcmVw
ZWF0ZWQgMSwwMDAsMDAwIHRpbWVzDQogIHNlZ3Y6IHNpZ25hbCBvZiBTSUdTRUdWLCByZXBlYXRl
ZCAzLDAwMCwwMDAgdGltZXMNCiAgZm9ya3dhaXRuOiBmb3JrL3dhaXQgZm9yIGNoaWxkIHRvIGV4
aXQsIHJlcGVhdGVkIDQwLDAwMCB0aW1lcw0KICBkaXZ6ZXJvOiBkaXZpZGUgYnkgMCBmYXVsdCAz
LDAwMCwwMDAgdGltZXMNCg==

------_=_NextPart_001_01C64C6A.1B56C5EF
Content-Type: text/plain;
	name="confid.2.6.16-rc6.txt"
Content-Transfer-Encoding: base64
Content-Description: confid.2.6.16-rc6.txt
Content-Disposition: attachment;
	filename="confid.2.6.16-rc6.txt"

Mi42LjE2LXJjNiBUcmFuc3BhcmVudCBQYXJhdmlydHVhbGl6YXRpb24gUGVyZm9ybWFuY2UgQ29u
ZmlkZW5jZSBJbnRlcnZhbCBXaWR0aHMyLjYuMTYtcmM2IFRyYW5zcGFyZW50IFBhcmF2aXJ0dWFs
aXphdGlvbiBQZXJmb3JtYW5jZSBDb25maWRlbmNlIEludGVydmFsIFdpZHRocw0KVXBkYXRlZDog
MDMvMjAvMjAwNiAqIENvbnRhY3Q6IEFubmUgSG9sbGVyIChhbm5lQHZtd2FyZS5jb20pDQpWYWx1
ZXMgYXJlIDk1JSBjb25maWRlbmNlIGludGVydmFsIHdpZHRoIGFyb3VuZCBtZWFuIGdpdmVuIGlu
IHRlcm1zIG9mIHBlcmNlbnRhZ2Ugb2YgbWVhbg0KDQogICAgICAgICAgICAgICAgICAgUDQgICAg
ICAgICAgICAgICAgICBPcHRlcm9uDQogICAgICAgICAgICAgICAgICAgTmF0aXZlIFZNSS1OYXRp
dmUgICBOYXRpdmUgVk1JLU5hdGl2ZQ0KIERiZW5jaDIuMA0KICAxY2xpZW50ICAgICAgICAgICAg
NS4wJSAgMS40JSAgICAgICAgICAwLjglICAzLjYlDQogTmV0cGVyZg0KICBSZWNlaXZlICAgICAg
ICAgICAgMC4xJSAgMC4wJSAgICAgICAgICAwLjAlICAwLjAlDQogIFNlbmQgICAgICAgICAgICAg
ICAwLjYlICAxLjglICAgICAgICAgIDAuMCUgIDAuMCUNCiBLZXJuZWwgY29tcGlsZQ0KICBVUCAg
ICAgICAgICAgICAgICAgMy40JSAgMi42JSAgICAgICAgICAyLjIlICAwLjAlDQogIFNNUC8yd2F5
ICAgICAgICAgICAyLjQlICA0LjklICAgICAgICAgIDQuMyUgIDQuMiUNCiBMbWJlbmNoIHByb2Nl
c3MgdGltZSBsYXRlbmNpZXMNCiAgbnVsbCBjYWxsICAgICAgICAgIDAuMCUgIDAuMCUgICAgICAg
ICAgMC4wJSAgMC4wJQ0KICBudWxsIGkvbyAgICAgICAgICAgMC4wJSAgMC4wJSAgICAgICAgICA1
LjIlIDEwLjglDQogIHN0YXQgICAgICAgICAgICAgICAxLjAlICAxLjAlICAgICAgICAgIDEuNyUg
IDMuMiUNCiAgb3BlbiBjbG9zICAgICAgICAgIDEuMyUgIDAuNyUgICAgICAgICAgMi40JSAgMy4w
JQ0KICBzbGN0IFRDUCAgICAgICAgICAgMC4zJSAgMC4zJSAgICAgICAgIDE5LjklIDIwLjElDQog
IHNpZyBpbnN0ICAgICAgICAgICAwLjMlICAwLjUlICAgICAgICAgIDAuMCUgIDUuNSUNCiAgc2ln
IGhuZGwgICAgICAgICAgIDAuNCUgIDAuNCUgICAgICAgICAgMi4wJSAgMi4wJQ0KICBmb3JrIHBy
b2MgICAgICAgICAgMC41JSAgMC45JSAgICAgICAgICAwLjglICAxLjAlDQogIGV4ZWMgcHJvYyAg
ICAgICAgICAwLjglICAwLjklICAgICAgICAgIDEuMCUgIDAuNyUNCiAgc2ggcHJvYyAgICAgICAg
ICAgIDAuMSUgIDAuMiUgICAgICAgICAgMC45JSAgMC40JQ0KIExtYmVuY2ggY29udGV4dCBzd2l0
Y2ggdGltZSBsYXRlbmNpZXMNCiAgMnAvMEsgICAgICAgICAgICAgIDAuOCUgIDEuOCUgICAgICAg
ICAxNi4xJSAgOS45JQ0KICAycC8xNksgICAgICAgICAgICAgMS41JSAgMS44JSAgICAgICAgIDEw
LjUlIDEwLjElDQogIDJwLzY0SyAgICAgICAgICAgICAyLjQlICAzLjAlICAgICAgICAgIDEuOCUg
IDEuNCUNCiAgOHAvMTZLICAgICAgICAgICAgIDQuNSUgIDQuMiUgICAgICAgICAgMi40JSAgNC4y
JQ0KICA4cC82NEsgICAgICAgICAgICAgMy4wJSAgMi44JSAgICAgICAgICAxLjYlICAxLjUlDQog
IDE2cC8xNksgICAgICAgICAgICAzLjElICA2LjclICAgICAgICAgIDIuNiUgIDMuMiUNCiAgMTZw
LzY0SyAgICAgICAgICAgIDAuNSUgIDAuNSUgICAgICAgICAgMi45JSAgMi45JQ0KIExtYmVuY2gg
c3lzdGVtIGxhdGVuY2llcw0KICBNbWFwICAgICAgICAgICAgICAgMC43JSAgMC4zJSAgICAgICAg
ICAyLjIlIDIuNCUNCiAgUHJvdCBGYXVsdCAgICAgICAgIDcuNCUgIDcuNSUgICAgICAgICA0OS40
JSAzOC43JQ0KICBQYWdlIEZhdWx0ICAgICAgICAgMC4yJSAgMC4yJSAgICAgICAgICAyLjQlICAy
LjklDQogS2VybmVsIE1pY3JvYmVuY2htYXJrcw0KICBnZXRwcGlkICAgICAgICAgICAgMS43JSAg
Mi45JSAgICAgICAgICAzLjUlICAzLjUlDQogIHNlZ3YgICAgICAgICAgICAgICAyLjMlICAwLjcl
ICAgICAgICAgIDEuOCUgIDEuOSUNCiAgZm9ya3dhaXRuICAgICAgICAgIDAuOCUgIDAuOCUgICAg
ICAgICAgNS4zJSAgMi4yJQ0KICBkaXZ6ZXJvICAgICAgICAgICAgMC45JSAgMS4zJSAgICAgICAg
ICAxLjIlICAxLjElDQo=

------_=_NextPart_001_01C64C6A.1B56C5EF--
